<?php
//error_reporting(E_ALL);
//ini_set('display_errors', '1');

function build_compiler_attribute($db, $grammar_id, $library_id, $user_id) {

	//change value to print comment in the prolog compiler file
	$comment=True;
	global $root;

	//======================================================
	//  INTRO, connect DB, open prolog file for compiler
	//=======================================================


	$compiler = fopen("$root/compiler/compiler_$user_id/compiler.pl", 'w') or die ("Cannot open the prolog file");


	//==================================================================
	//   CONSTRUCTION OF THE PROLOG ATTRIBUTE COMPILER
	//==================================================================
	fwrite($compiler, "%---------------ATTRIBUTE COMPILER---------------\n");
	fwrite($compiler, "%You may call:\n
	%write_dna(DNA_Sequence)\n
	%dna2parts(DNA_Sequence, Tokens)\n
	%write_parts(Tokens)\n
	%check_grammar(Tokens)\n
	%then \n
	%produce_sbml(Tokens)\n
	%and/or \n
	%produce_code\n
	");


	//%-------------------------------Intro-----------------------------

	fwrite($compiler, "%=====INTRO====\n");

	//
	//% call go. then DNA sequence for input

	fwrite($compiler, "
      	go(Tokens):- check_grammar(Tokens), produce_sbml(Tokens),produce_code.		  
      \n");

	/*fwrite($compiler, "
      	go_dna(DNA_Sequence):- dna2parts(DNA_Sequence, Tokens), check_grammar(Tokens), produce_sbml(Tokens),produce_code.		  
      \n");*/

	fwrite($compiler, "
      	go_parts(Tokens):- check_grammar(Tokens), produce_sbml(Tokens),produce_code.		  
      \n");

	fwrite($compiler, "
      	parts2sbml(Tokens):-check_grammar(Tokens), produce_sbml(Tokens).		  
      \n");

	fwrite($compiler, "
      parts2chemicalequations(Tokens) :- check_grammar(Tokens),produce_code.		  
      \n");



	/*//%-------------------------------Write DNA-----------------------------
	//Debug!
	fwrite($compiler, "
      %=====WRITE DNA SEQUENCE====
      
      write_dna(DNA_Sequence) :- tell('result.txt'),write('DNA sequence = '),write(DNA_Sequence), nl, told.
      \n");
	//%-------------------------------DNA to Tokens-----------------------------
	fwrite($compiler, "
      %=====COMPUTE PARTS LIST FROM DNA====
      
      dna2parts(DNA_Sequence, Tokens) :- atom_chars(DNA_Sequence, XL2), string_to_list(XL2, XL3), combination(Tokens, XL3).
      
      combination(Tokens, []) :- concat([],[], Tokens).
      combination(Tokens, ListA) :- sequence(Name, Sequence), string_to_list(Sequence, TB), prefix(TB, ListA, R), combination(Tokens2, R), concat( [Name],Tokens2, Tokens).
      
      prefix([X], [X|R], R).
      prefix([X|R1], [X|R2], R) :- prefix(R1, R2, R).
      prefix([X], [Y|R], R) :- X is Y+32.
      prefix([X|R1], [Y|R2], R) :- X is Y+32, prefix(R1, R2, R).
      
      concat([],L,L).
      concat([X|Rest],L,[X|Rest1]) :- concat(Rest,L,Rest1).
      %concat(A,B,C,R) :- concat(A,B,X), concat(X,C,R).
      %concat(A,B,C,D,R) :- concat(A,B,X), concat(C,D,Y), concat(X,Y,R).
      %concat(A,B,C,D,E,R) :- concat(A,B,X), concat(C,D,Y), concat(X,Y,E,R).
      %concat(A,B,C,D,E,F,R) :- concat(A,B,C,D,X), concat(E,F,Y), concat(X,Y,R).
      %concat(A,B,C,D,E,F,G,H,R) :- concat(A,B,C,D,X), concat(E,F,G,H,Y), concat(X,Y,R).
      \n");
*/
	//%-------------------------------Write Tokens-----------------------------
	//Debug!
	fwrite($compiler, "
      %=====WRITE PARTS LIST====
      
      write_parts(Tokens) :- tell('result.txt'), 
			   				 write(Tokens),
							nl, told.				   
      %printstructure(Tokens),nl.
      %printstructure([]).
      %printstructure([Head|Rest]) :- sequence(Head, Sequence), nl(Result), write(Result, Head), write(':'), write(Result, Sequence), nl(Result), printstructure(Rest).
      \n");


	//%-------------------------------Check grammar-----------------------------

	//grammar starts with S, its grammar_id is NULL
	//get S id

	$r=mysql_query("SELECT starting_category_id FROM grammars WHERE grammar_id=$grammar_id",$db);//S should be enter only once in the db
	$start = mysql_fetch_array($r);
	$start = "c".$start[0];

	//get init code
	$r=mysql_query("SELECT code_init FROM attribute_grammar WHERE grammar_id=$grammar_id",$db);
	$init = mysql_fetch_array($r);

	fwrite($compiler, "
      %=====CHECK GRAMMAR====


      check_grammar(Tokens) :- $init[0]$start(Tokens, []).
      \n");//the output of the compiler is in equations

	//#1: We compute the list of categories used by this grammar to avaoir useless declaration of parts
	$y=0;
	$cat_used = array();//store cat id
	$index=0;
	$cat_having_parts = array();//store cat id if they have parts attached to them

	//query for grammar's rules (come with letters of categories)
	$rules = mysql_query("SELECT change_from, change_to FROM rules WHERE grammar_id=$grammar_id", $db);

	//for each rule
	while($rule = mysql_fetch_array($rules)) {

		$change_f0=$rule[0];
		$change_t0=explode(" ", $rule[1]);
		unset($change_to);

		//rewrite with category_id instead
		//left
		$r=mysql_query("SELECT category_id FROM categories WHERE letter='".$change_f0."' AND (grammar_id=$grammar_id or grammar_id is null)", $db);
		$change_from = mysql_fetch_array($r);
		$change_from = "c".$change_from[0];
		//right
		for ($k = 0; $k < count($change_t0); $k++){
			$r=mysql_query("SELECT category_id FROM categories WHERE letter='".$change_t0[$k]."' AND (grammar_id=$grammar_id or grammar_id is null)", $db);
			$change_t = mysql_fetch_array($r);
			$change_to[$k] = "c".$change_t[0];
			//store final categories
			if (!in_array($change_t[0], $cat_used)){
				$cat_used[$y]=$change_t[0];$y++;

				//check if category has parts
				$parts=mysql_query("SELECT count(id) FROM categories_parts WHERE category_id='".$change_t[0]."' AND part_id IN (select part_id from library_part_join where library_id=$library_id)", $db);
				$nb_parts = mysql_fetch_array($parts);
				if ($nb_parts[0]>=1){
					$cat_having_parts[$index]=$change_t[0];$index++;
				}
			}
		}

	}



	//#2: We write the rules

	//query
	$rules = mysql_query("SELECT change_from, change_to, rule_id FROM rules WHERE grammar_id=$grammar_id", $db);

	//for each rule
	while($rule = mysql_fetch_array($rules)) {

		fwrite($compiler, "\n");


		//LEFT

		$change_f0=$rule[0];
		$change_t0=explode(" ", $rule[1]);
		unset($change_to);	//very important

		//rewrite with category id instead
		//left
		$r=mysql_query("SELECT category_id FROM categories WHERE letter='".$change_f0."' AND (grammar_id=$grammar_id or grammar_id is null)", $db);
		$change_from = mysql_fetch_array($r);


		//ATTRIBUTES
		$att="(";$cat_atts="";

		//if category has part(s), its first attribute is the part name
		if (in_array($change_from[0], $cat_having_parts)){
			$att=$att."Name$change_from[0],";
		}

		//does this category have attributes?yes? write cX(AY, AZ, ...) where X, Y, Z are ids
		$attributes = mysql_query("SELECT id FROM category_attribute WHERE category_id=$change_from[0] ORDER BY id", $db);

		while($attribute = mysql_fetch_array($attributes)) {
			$att=$att."A".$attribute[0].",";
		}


		//does it have attributes to pass ?
		$attributes_to_pass = mysql_query("SELECT attribute_id FROM attributes_to_pass WHERE category_id=$change_from[0] ORDER BY attribute_id", $db);
		while($attribute_to_pass = mysql_fetch_array($attributes_to_pass)) {
			$att=$att."Ap".$attribute_to_pass[0].",";
		}
			
			
		if (strlen($att)!=1){//because it is still "("
			$cat_atts=substr($att,0,-1);
			$cat_atts=$cat_atts.")";
		}else{
				
			//no attribute
			$cat_atts="";
		}




		$change_from = "c".$change_from[0].$cat_atts;

		//RIGHT

		//in case a category is used more than one, we must named its attribute by ifferent names for prolog
		//so we compute the occurence of the categories in the right part of the rule
		$cat_occurence=array_count_values($change_t0);


		for ($k = 0; $k < count($change_t0); $k++){
			$r=mysql_query("SELECT category_id FROM categories WHERE letter='".$change_t0[$k]."' AND (grammar_id=$grammar_id or grammar_id is null)", $db);
			//unset($change_t);
			$change_t = mysql_fetch_array($r);

			//ATTRIBUTES
			$att="(";$cat_atts="";
				
		//avoid attribute id ducplicate
                        if ($cat_occurence[$change_t0[$k]]>1){                          
                                $cat_occurence[$change_t0[$k]]--;//so we have nothing, o1, o2,...
                                $occurence="o".$cat_occurence[$change_t0[$k]];
                        }
                        else {$occurence="";}
				
			//if category has part(s), its first attribute is the part name
			if (in_array($change_t[0], $cat_having_parts)){
				$att=$att."Name".$change_t[0].$occurence.",";
			}

			//does this category have attributes?yes? write cX(AY, AZ, ...) where X, Y, Z are ids
			$attributes = mysql_query("SELECT id FROM category_attribute WHERE category_id=$change_t[0] ORDER BY id", $db);
				
			while($attribute = mysql_fetch_array($attributes)){
					
				$att=$att."A".$attribute[0].$occurence.",";
			}
			//does it have attributes to pass too?
			$attributes_to_pass = mysql_query("SELECT id FROM attributes_to_pass WHERE category_id=$change_t[0] ORDER BY id", $db);
			while($attribute_to_pass = mysql_fetch_array($attributes_to_pass)) {
				$att=$att."Ap".$attribute_to_pass[0].",";
			}

			if (strlen($att)!=1){
				$cat_atts=substr($att,0,-1);
				$cat_atts=$cat_atts.")";
			}else{
				//no attribute
				$cat_atts="";
			}


			$change_to[$k] = "c".$change_t[0].$cat_atts;
		}


		//write the rule as comment
		if ($comment){
			fwrite($compiler, '%'.$rule[0].' --'.chr(62).' '.$rule[1]."\n");
		}


		//write left part
		fwrite($compiler, $change_from.' --'.chr(62).' ');

		//right part
		//empty
		if ($change_t0[0]==null){fwrite($compiler, "[]. \n");
		}else{
			//normal case
			for ($k = 0; $k < count($change_to); $k++){
				fwrite($compiler, $change_to[$k]);
				if($k<(count($change_to)-1)){fwrite($compiler, ", ");}
			}

			//check if there is a semantic action to be performed
			$actions = mysql_query("SELECT action FROM rule_semantic_action WHERE rule_id=$rule[2]", $db);
			while($action = mysql_fetch_array($actions)){
				fwrite($compiler, ", {".$action[0]."}");
			}

			//finish writing rule
			fwrite($compiler, ".\n");
		}



	}//end while rules

	fwrite($compiler, "\n");






	//==================================================================
	//Equations code generation
	//==================================================================


	fwrite($compiler, "%---------------SEMANTIC ACTIONS---------------\n");
	fwrite($compiler, "\n");
	$sem=mysql_query("SELECT code FROM code_tbgenerated WHERE grammar_id=$grammar_id", $db);
	while($semcode = mysql_fetch_array($sem)){
		fwrite($compiler, $semcode[0]);
		fwrite($compiler, "\n");
	}




	//==================================================================
	//PARTS SECTION
	//==================================================================
	fwrite($compiler, "%---------------PARTS---------------\n");
	fwrite($compiler, "\n");


	// $parts_used=array();//to avoid declaring the dna sequence multiple time as a parts can belong to several categories
	//$index=0;

	//for each category
	for ($k = 0; $k < sizeof($cat_used); $k++){

		//get cat info
		$r=mysql_query("SELECT * FROM categories WHERE category_id=$cat_used[$k]", $db);
		$cat = mysql_fetch_array($r);


		$the_cat=$cat[0];

		$cat[0] = "c".$cat[0];

		//get the parts of that actegory and from the chosen library
		$parts = mysql_query("SELECT parts.* FROM parts, library_part_join, categories_parts WHERE parts.id=library_part_join.part_id AND library_id=$library_id AND parts.id=categories_parts.part_id AND categories_parts.category_id=$cat_used[$k] AND parts.part_id!='empty'", $db);


		//for each part

		while($part = mysql_fetch_array($parts)) {



			//#0: get the value of attributes for this part
			//does this category have attributes?yes? write cX(value1,value2,...)
			//we need to keep the same order!!
			$attributes = mysql_query("SELECT id, attribute_type_id FROM category_attribute WHERE category_id=$the_cat ORDER BY id", $db);
			$att="(";
				
			//all parts have their name for first attribute
			$att=$att."'".$part[2]."',";
				
			while($attribute = mysql_fetch_array($attributes)){
				$vals=mysql_query("SELECT value FROM parts_category_attribute_assign WHERE category_attribute_id=$attribute[0] and part_id=$part[0]", $db);
				$att_temp="";
					
				if ($attribute[1]==1){	//there are more than one value for one type of attribute
					//it is a list, of ids...we want the names
						
					while($val=mysql_fetch_array($vals)){
						$parts_names = mysql_query("SELECT parts.description FROM parts WHERE parts.id=$val[0]", $db);
						$part_name = mysql_fetch_array($parts_names);

						$att_temp=$att_temp."'".$part_name[0]."',";
					}
						
					$att_temp=substr($att_temp,0,-1);//removes last ,
					$att=$att."[".$att_temp."],";
				}else{
					$val=mysql_fetch_array($vals);
					$att=$att.$val[0].",";
				}
					
					
			}
			if (strlen($att)!=1){
				$cat_atts=substr($att,0,-1);
				$cat_atts=$cat_atts.")";
			}else{
				$cat_atts="";
			}


			$cat[0]="c".$the_cat.$cat_atts;

			//#1: definition of the part type
			//give: part_type --  [name].

			$part[0]="p".$part[0];//."c".$the_cat;

			//write the part_type -- [name].  as comment
			if ($comment){fwrite($compiler, "%".$cat[1]."--".chr(62)."[".$part[2]."]\n");}

			if(!in_array($cat[0], $dont_use)){
				fwrite($compiler, $cat[0]." --".chr(62)." [".$part[0]."].\n");
			}else{
				fwrite($compiler, $cat[0]." --".chr(62)." [".$part[0]."], ".$cat[0]."bis.\n");}//involve X that has appeared in a rule X to Xa|b

				//#2: sequence
				//give: sequence(name, dna).
				//$part[3]=strtolower($part[3]);
				//$part[3]=str_replace("\n","",$part[3]);
				//$dna_sequences=$dna_sequences."sequence(".$part[0].", '".trim($part[3])."').\n";

		}
	}

//	fwrite($compiler, $dna_sequences."\n");




	//%-------------------------------Write answer grammar-----------------------------
	//will be written only if the grammar test has passed.

	fwrite($compiler, "
      %=====Answer grammar====
      
      answer_grammar :- tell('result.txt'), nb_getval(equations, Res), write(Res),told.
      \n");


	//=========================================================
	//     END
	//========================================================




	fclose($compiler);


}

?>
