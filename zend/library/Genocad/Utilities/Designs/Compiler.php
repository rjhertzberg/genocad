<?php
class Genocad_Utilities_Designs_Compiler
{
	public static function getCompilerDirectory() {
		// Get the user_id (if applicable)
		if (Genocad_Application::isLoggedIn()) {
			$userId = Genocad_Application::getUser()->user_id;
		} else {
			// user not logged in
			$userId = 0;
		}	
		
		$dirName = Zend_Registry::get('config')->compiler->root."compiler" ;
		
		if (!is_dir($dirName)) {
			// die, because it is assumed the compiler directory exists
			die("Configuration error -- compiler directory does not exist under compiler.root".$dirName);
		}
		
		//Now check to see if the user-specific subdirectory exists
		$dirName .= '/compiler_'.trim($userId);
		
		if (!is_dir($dirName)) {
			exec("mkdir ".$dirName);
			chmod($dirName, 0777);
		}
		
		return($dirName);
	}
	
	public static function buildCompilerAttribute($dirName, $libraryId, $grammarId){
		// Generate a random number -- this will be returned by the function and will be appended to all of the associated file names
		$randInt = rand();
		
		//change value to print comment in the prolog compiler file
		$comment=True;
		
		$dbParts = new Application_Model_DbTable_Parts();
		$dbCategories = new Application_Model_DbTable_Categories();
        $dbLibraryParts = new Application_Model_DbTable_LibraryParts();
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $dbAttributeGrammars = new Application_Model_DbTable_AttributeGrammars();
        $dbCategoryAttributes = new Application_Model_DbTable_CategoryAttributes();
        $dbCategoryParts = new Application_Model_DbTable_CategoryParts();
        $dbAttributesToPass = new Application_Model_DbTable_AttributesToPass();
        
        $grammar = $dbGrammars->find($grammarId)->current();
        
        //======================================================
		//  INTRO, connect DB, open prolog file for compiler
		//=======================================================


		$compiler = fopen($dirName."/compiler_".$randInt.".pl", 'w') or die ("Cannot open the prolog file");


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
      		go(Tokens):- check_grammar(Tokens).		  
      		\n");

		fwrite($compiler, "
      		go_parts(Tokens):- check_grammar(Tokens), produce_sbml(Tokens),produce_code.		  
      		\n");

		fwrite($compiler, "
      		parts2sbml(Tokens):-check_grammar(Tokens), produce_sbml(Tokens).		  
      		\n");

		fwrite($compiler, "
      		parts2chemicalequations(Tokens) :- check_grammar(Tokens),produce_code.		  
      		\n");


		
		//%-------------------------------Write Tokens-----------------------------
		fwrite($compiler, "
      		%=====WRITE PARTS LIST====
      
      		write_parts(Tokens) :- tell('result".$randInt.".txt'), 
			   				 write(Tokens),
							nl, told.				   
      		%printstructure(Tokens),nl.
      		%printstructure([]).
      		%printstructure([Head|Rest]) :- sequence(Head, Sequence), nl(Result), write(Result, Head), write(':'), write(Result, Sequence), nl(Result), printstructure(Rest).
      		\n");
		
	
	//%-------------------------------Check grammar-----------------------------

		$start = "c".$grammar->starting_category_id;
		$startCategory = $dbCategories->find($grammar->starting_category_id)->current();
		$attributeList = "";
		
		// Does S have parts?
		if ($startCategory->hasParts()) {
			$attributeList = "NameStart, ";
		}

		// for every S attribute write S1,  ie, 5 attributes = "S1, S2, S3, S4, S5,"
		$attributeCount = $startCategory->countAttributes();
		
		for ($i = 1; $i <= $attributeCount; $i++) {
			$attributeList .= "S".trim($i).", ";
		}
		
		//get init code
		$attributeGrammar = $dbAttributeGrammars->find($grammarId)->current();
		$init = $attributeGrammar->code_init;
		if (strlen($attributeGrammar->code_end) > 0) {
			$end = ",".$attributeGrammar->code_end;
		} else {
			$end = "";
		}

		fwrite($compiler, "
      	%=====CHECK GRAMMAR====


      	check_grammar(Tokens) :- $init$start(".$attributeList."Tokens, []) $end .
      	\n");//the output of the compiler is in equations

		//#1: We compute the list of categories used by this grammar to avoid useless declaration of parts
		$y=0;
		$cat_used = array("0");//store cat id
		$index=0;
		$cat_having_parts = array();//store cat id if they have parts attached to them

		//query for grammar's rules (come with letters of categories)
		$rules = $grammar->getRules();
				
		//for each rule
		foreach ($rules as $rule) {

			// left
			$change_from_id=$rule->category_id;
			$change_from = "c".$change_from_id;
			
			//right
			$change_to=$rule->getRuleTransform();
			
			foreach ($change_to as $change_t0){
				$change_to_val = $change_t0->category_id;
							
				//store final categories
				if (!(in_array($change_to_val, $cat_used))){
					$cat_used[$y]=$change_to_val;
					$y++;

					//check if category has parts
					$nb_parts = count($dbParts->getPartsByLibraryCategory($libraryId, $change_to_val));
					if ($nb_parts >= 1){
						$cat_having_parts[$index]=$change_to_val;
						$index++;
					}
				}
			}
		}
				
		//#2: We write the rules

		//query
		
		//for each rule
		foreach ($rules as $rule) {
			// 12-06-2011 Can we somehow merge this with #1 above?
			fwrite($compiler, "\n");

			//LEFT
            $change_from_id=$rule->category_id;
			$change_t0=$rule->getRuleTransform();
			
			unset($change_to);	//very important
			unset($change_to_out);
			$change_to_out = Array();

			//ATTRIBUTES
			$att="(";
			$cat_atts="";
			
			//delete later
			$catHavingParts = implode(" ", $cat_having_parts);

			//if category has part(s), its first attribute is the part name
			if (in_array($change_from_id, $cat_having_parts)){
				//die("Could find ".$change_from_id." in ".$catHavingParts);
				$att=$att."Name$change_from_id,";
			} else {
				//die("could not find ".$change_from_id." in ".$catHavingParts);
			}

			//does this category have attributes?yes? write cX(AY, AZ, ...) where X, Y, Z are ids
			$category = $dbCategories->find($change_from_id)->current();
			$attributes = $category->getAttributes();

			foreach ($attributes as $attribute) {
				$att=$att."A".$attribute->id.",";
				
			}


			//does it have attributes to pass ?
			// Mandy 11-02-2011 -- we decided for the first release that attributes_to_pass was too ambitious.  It may be removed altogether, but commenting out for now.
			
			//$attributes_to_pass = $category->getAttributesToPass();
			//$atts_passed = array();
			//foreach ($attributes_to_pass as $attribute_to_pass) {
			//	$att=$att."A".$attribute_to_pass->attribute_id.",";
			//	$atts_passed[] = $attribute_to_pass->attribute_id;	
			//}
			
			//foreach($atts_passed as $att_val){
			//	$categoryAttribute = $dbCategoryAttributes->find($att_val)->current();
			//	$att=$att."Name".$categoryAttribute->category_id.",";
			//}
			
			
			if (strlen($att)!=1){//because it is still "("
				$cat_atts=substr($att,0,-1);
				$cat_atts=$cat_atts.")";
			}else{
				
				//no attribute
				$cat_atts="";
			}

			$change_from = "c".$change_from_id.$cat_atts;
			$change_from_out = $category->letter;

			//RIGHT

			//in case a category is used more than once, we must name its attribute by different names for prolog
			//so we compute the occurence of the categories in the right part of the rule
			$category_list = Array();
			
			// add the change_from value to this list to make sure it gets counted, too
			$category_list[0] = $change_from_id;
			$categoryCount = 1;
			
			foreach($change_t0 as $changed){
				$category_list[$categoryCount] = $changed->category_id;
				$categoryCount++;
			}
			
			$cat_occurence=array_count_values($category_list);

			$k = 0;
			foreach ($change_t0 as $changed) {
				$change_t = $changed->category_id;
				
				//ATTRIBUTES
				$att="(";$cat_atts="";
				
				//avoid attribute id duplicate
				// Mandy 12-06-2011 Are we actually writing the letter here instead of the category_id?  Start here!
                if ($cat_occurence[$change_t]>1){                          
                	$cat_occurence[$change_t]--;//so we have nothing, o1, o2,...
                    $occurence="o".$cat_occurence[$change_t];
                } else {
                	$occurence="";
                }
				
				//if category has part(s), its first attribute is the part name
				if (in_array($change_t, $cat_having_parts)){
					$att=$att."Name".$change_t.$occurence.",";
				}

				//does this category have attributes?yes? write cX(AY, AZ, ...) where X, Y, Z are ids
				$category = $dbCategories->find($change_t)->current();
				$attributes = $category->getAttributes();
				
				foreach ($attributes as $attribute){
					$att=$att."A".$attribute->id.$occurence.",";
				}
				
				//does it have attributes to pass too?
				// Mandy 11-02-2011 Decided attributes_to_pass was too ambitious for first run.  May include later, so commenting out for now
				//$attributes_to_pass = $category->getAttributesToPass();
				//$atts_passed = array();
				//foreach ($attributes_to_pass as $attribute_to_pass) {
				//	$att=$att."Ap".$attribute_to_pass->attribute_id.",";
				//	$atts_passed[] = $attribute_to_pass->attribute_id;	
				//}
			
				//foreach($atts_passed as $att_val){
				//	$categoryAttribute = $dbCategoryAttributes->find($att_val)->current();
				//	$att=$att."Name".$categoryAttribute->category_id."p,";
				//}
				
				if (strlen($att)!=1){
					$cat_atts=substr($att,0,-1);
					$cat_atts=$cat_atts.")";
				}else{
					//no attribute
					$cat_atts="";
				}


				$change_to[$k] = "c".$change_t.$cat_atts;
				$change_to_out[$k] = $category->letter;
				$k++;
			}

			//write the rule as comment
			if ($comment){
				fwrite($compiler, '%'.$change_from_out.' --'.chr(62).' '.implode(" ", $change_to_out)."\n");
			}

			//write left part
			fwrite($compiler, $change_from.' --'.chr(62).' ');

			//right part
			//empty
			if (count($change_t0) == 0) {
				fwrite($compiler, "[]");
			}else{
				//normal case
				for ($k = 0; $k < count($change_to); $k++){
					fwrite($compiler, $change_to[$k]);
					if($k<(count($change_to)-1)){fwrite($compiler, ", ");
				}
			}
			}
			//check if there is a semantic action to be performed
			$actions = $rule->getRuleSemanticActions();
			foreach ($actions as $action){
				fwrite($compiler, ", {".$action->action."}");
			}

			//finish writing rule
			fwrite($compiler, ".\n");
		

	}//end while rules

		fwrite($compiler, "\n");
	
		//==================================================================
		//Equations code generation
		//==================================================================

		fwrite($compiler, "%---------------SEMANTIC ACTIONS---------------\n");
		fwrite($compiler, "\n");
	
		$sem=$grammar->getCodeTbgenerated();
		foreach ($sem as $semcode){
			fwrite($compiler, $semcode->code);
			fwrite($compiler, "\n");
		}
	
	//==================================================================
	//PARTS SECTION
	//==================================================================
	fwrite($compiler, "%---------------PARTS---------------\n");
	fwrite($compiler, "\n");

	//for each category
	for ($k = 0; $k < sizeof($cat_used); $k++){

		//get cat info
		$cat = $dbCategories->find($cat_used[$k])->current();
		
		$attributes = $cat->getAttributes();
			
		//get the parts of that category and from the chosen library
		$parts = $dbParts->getPartsByLibraryCategory($libraryId, $cat->category_id);

		//for each part

		foreach($parts as $part) {

			//#0: get the value of attributes for this part
			//does this category have attributes?yes? write cX(value1,value2,...)
			//we need to keep the same order!!
			
			$att="(";
				
			//all parts have their name for first attribute
			$att=$att."'".str_replace(" ", "_", trim($part->description))."',";
			
			foreach($attributes as $attribute){
				$vals=$attribute->getPartValues($part->id);
				$att_temp="";
					
				if ($attribute->attribute_type_id==1){	//there are more than one value for one type of attribute
					//it is a list, of ids...we want the names

					if ($vals != ""){
						foreach ($vals as $val){
							$listPart = $dbParts->find($val->value)->current();
													
							$att_temp=$att_temp."'".str_replace(" ", "_", trim($listPart->description))."',";
						}
					}	
						
					$att_temp=substr($att_temp,0,-1);//removes last ,
					$att=$att."[".$att_temp."],";
				} elseif ($attribute->attribute_type_id==2){	//there are more than one value for one type of attribute
					//it is a list, of ids...we want the names

					if ($vals != ""){
						foreach ($vals as $val){
							//remove stuffs
							$couple=$val->value;
							$couple=str_replace(" ","",$couple);
							$couple=str_replace("[","",$couple);
							$couple=str_replace("]","",$couple);
							//couple is [<part_id>,value]
							$coupletab=explode(",",$couple);
							$listPart = $dbParts->find($coupletab[0])->current();
													
							$att_temp=$att_temp."['".str_replace(" ", "_", trim($listPart->description))."',".$coupletab[1]."],";

						}
					}	
						
					$att_temp=substr($att_temp,0,-1);//removes last ,
					$att=$att."[".$att_temp."],";
				} elseif ($vals != ""){
					$att=$att.$vals[0]->value.",";	
				}


			}

			if (strlen($att)!=1){
				$cat_atts=substr($att,0,-1);
				$cat_atts=$cat_atts.")";
			} else {
				$cat_atts="";
			}

			$catOut="c".$cat->category_id.$cat_atts;

			//#1: definition of the part type
			//give: part_type --  [name].

			$partOut="p".$part->id;
			
			//write the part_type -- [name].  as comment
			if ($comment){
				fwrite($compiler, "%".$cat->letter."--".chr(62)."[".str_replace(" ", "_", trim($part->description))."]\n");
			}
			
			fwrite($compiler, $catOut." --".chr(62)." [".$partOut."].\n");
		}}

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
		return($randInt);
		
	}

	public static function buildCompilerNoOrphan($dirName, $libraryId, $grammarId){
		// Generate a random number -- this will be returned by the function and will be appended to all of the associated file names
		$randInt = rand();
		
		$comment=True;
		
		$dbParts = new Application_Model_DbTable_Parts();
		$dbCategories = new Application_Model_DbTable_Categories();
		$dbLibraries = new Application_Model_DbTable_Libraries();
        $dbLibraryParts = new Application_Model_DbTable_LibraryParts();
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $dbCategoryParts = new Application_Model_DbTable_CategoryParts();
        
        $grammar = $dbGrammars->find($grammarId)->current();
        $library = $dbLibraries->find($libraryId)->current();
		 
		//======================================================
      	//  INTRO, connect DB, open prolog file for compiler
      	//=======================================================

 		$compiler = fopen($dirName."/syntax/compiler_".$randInt.".pl", 'w') or die ("Cannot open the prolog file");

      	//==================================================================
		//   CONSTRUCTION OF THE PROLOG COMPILER
		//==================================================================

      	fwrite($compiler, "%---------------COMPILER---------------\n");

      	//%-------------------------------Intro-----------------------------

      	fwrite($compiler, "%=====INTRO====\n");

      	//% call go. then DNA sequence for input

      	fwrite($compiler, "

      		go(DNA_Sequence) :-

                      dna_to_parts(DNA_Sequence, Tokens),

                      check_grammar(Tokens),

                      write_parts(Tokens).

      		\n");

 

      fwrite($compiler, "

      		dna2parts(DNA_Sequence) :-

                dna_to_parts(DNA_Sequence, Tokens),

                      write_parts(Tokens).

       		\n");

      fwrite($compiler, "

      	grammar(Tokens) :-

                      check_grammar(Tokens),

                      answer_grammar.

        \n");

       //%-------------------------------Write DNA-----------------------------

      fwrite($compiler, "

      	%=====WRITE DNA SEQUENCE====

           write_dna(DNA_Sequence) :- tell('result_".$randInt.".txt'),

                                            write('DNA sequence = '),

                                            write(DNA_Sequence),

                                        nl, told.

       \n");

      //%-------------------------------Find Tokens-----------------------------

      fwrite($compiler, "

      %=====COMPUTE PARTS LIST FROM DNA====

      dna_to_parts(DNA_Sequence, Tokens) :- atom_chars(DNA_Sequence, XL2), string_to_list(XL2, XL3), combination(Tokens, XL3).

      combination(Tokens, []) :- concat([],[], Tokens).

      combination(Tokens, ListA) :- sequence(Name, Sequence), string_to_list(Sequence, TB), prefix(TB, ListA, R), combination(Tokens2, R), concat( [Name],Tokens2, Tokens).

      prefix([X], [X|R], R).

      prefix([X|R1], [X|R2], R) :- prefix(R1, R2, R).

      prefix([X], [Y|R], R) :- X is Y+32.

      prefix([X|R1], [Y|R2], R) :- X is Y+32, prefix(R1, R2, R).
     

      concat([],L,L).

      concat([X|Rest],L,[X|Rest1]) :- concat(Rest,L,Rest1).

      concat(A,B,C,R) :- concat(A,B,X), concat(X,C,R).

      concat(A,B,C,D,R) :- concat(A,B,X), concat(C,D,Y), concat(X,Y,R).

      concat(A,B,C,D,E,R) :- concat(A,B,X), concat(C,D,Y), concat(X,Y,E,R).

      concat(A,B,C,D,E,F,R) :- concat(A,B,C,D,X), concat(E,F,Y), concat(X,Y,R).

      concat(A,B,C,D,E,F,G,H,R) :- concat(A,B,C,D,X), concat(E,F,G,H,Y), concat(X,Y,R).

      \n");

      //%-------------------------------Write Tokens-----------------------------

      fwrite($compiler, "

      %=====WRITE PARTS LIST====

      write_parts(Tokens) :- 

                          tell('result_".$randInt.".txt'),

                                      %write('DNA structure = '),

                                write(Tokens),

                                      nl, told.                     

      %printstructure(Tokens),nl.
     

      %printstructure([]).

      %printstructure([Head|Rest]) :- sequence(Head, Sequence), nl(Result), write(Result, Head), write(':'), write(Result, Sequence), nl(Result), printstructure(Rest).

      \n");

      //%-------------------------------Check grammar-----------------------------
      // Get starting category_id
      
      $start = "c".$grammar->starting_category_id;

      fwrite($compiler, "

      %=====CHECK GRAMMAR====

      check_grammar(Tokens) :- ".$start."(Tokens, []).

      \n");
      
      #1:find the set of rules we can use

      $finish=false;

      $orphan_rule=array();
      
      $orphans = array();
      
      $i=0;

      $o=0;

      //while we remove rules
      
      $rules = $grammar->getRules();

      $categories = $grammar->getCategories();
      
	  $modelCategoryId = 0;
      foreach($categories as $category) {
			// find the model id
			if ($category->letter == 'MDL') {
				$modelCategoryId = $category->category_id;
			}
      }
      
      while (!$finish){
      	
            $finish=true;

            //
            //We compute "orphans" that store all symbole that are orphans (no parts and not involved in the left parts of a rule)

            
            
            //for each category
            //if it has no parts attached
            //then get all the left side of the rules of this grammar.
            //if it is not in the left never, then never write a rule that uses this category
            //query for grammar's rules (come with letters of categories)

            foreach ($categories as $category) {
                  $catido=$category->category_id;
                  
                  if (!(in_array($catido, $orphans))) {
                  	// Get category
                  	
                  	// see how many parts the category has
                  	$nb_parts = count($dbParts->getPartsByLibraryCategory($libraryId, $catido));
                  	
                  	//if this category has not part
                  	if($nb_parts == 0){
                        //is it on the left of a rule?                 
						$left = false;
                  		foreach ($rules as $rule) {
                  			if (!(in_array($rule->rule_id, $orphan_rule))) {
                  				if ($rule->category_id == $catido) {
                  					// have to also check to make sure that the rule is not pointing to itself only ie O -> O O -- if it is, then can't count as a 
                  					// left rule (and we wouldn't have made it this far if it had parts.
                  					$transforms = $rule->getRuleTransform();
                  					
                  					if (count($transforms) == 0) {
                  						// empty rule
                  						$left = true;
                  					} else {
                  						foreach ($transforms as $transform) {
                  							if ($transform->category_id != $catido) {
                  								$left = true;
                  							}	
                  						}
                  					}	
                  				}
                  			}
                  		}	
                  		
                        if (!($left)) {
							  $orphans[$i] = $catido;
                              $i++;
                        }
                  }
                  
                  }  
            }
            
            // for each orphan
      		//fwrite($compiler, "%ORPHANS\n");
		
			//foreach ($orphans as $orphan){
			//	fwrite($compiler, "%".$orphan."\n");
			//}

            //for each rule

            foreach ($rules as $rule) {
            	if (!(in_array($rule->rule_id, $orphan_rule))) {

                  	$change_t0 = $rule->getRuleTransform();

                  	unset($change_to);      //very important

                  	foreach ($change_t0 as $change_t) {
                        if(in_array($change_t->category_id,$orphans)){

                              $orphan_rule[$o]=$rule->rule_id;

                              $o=$o+1;

                              $finish=false;
                        }
                   	}
            	}       	
            }//end while rules
      }//end while we remove rule

      //#3: We compute "don't use" that store all symbole that are involved in a rule type: X-->X,b
      //and compute the list of categories used by this grammar to avaoir useless declaration of parts

      $i=0;
      $dont_use = array();
      $y=0;
      $cat_used = array();

      //query for grammar's rules (come with letters of categories)
      //for each rule
      foreach ($rules as $rule) {
      		if (!(in_array($rule->rule_id, $orphan_rule))) {
            	$change_f0=$rule->category_id;
            	unset($change_to);

            	//rewrite with category_id instead
            	//left
            	$change_from = "c".$change_f0;

            	//right

            	$change_t0 = $rule->getRuleTransform();
            	
            	$k = 0;
            	foreach($change_t0 as $change_t) {
            		$change_to[$k] = "c".$change_t->category_id;
					$k++;
					
                  	//store final categories
                  	if (!in_array($change_t->category_id, $cat_used)) {
                  		$cat_used[$y]=$change_t->category_id;
                  		$y++;
                  	}
            	}

            	if(count($change_to)>=2 && $change_from==$change_to[0]){
                  	$dont_use[$i]=$change_from;
                  	$i++;
            	}
      		}      	
		}

      	//#4: We write the rules paying attention to X-->X,b
      	//we actually remove left recusrsion with the following principle
      	//if X--> Xa|b
      	//it becomes
      	//X-->bX'
      	//X'-->aX'|[]

      	//query not orphan rules
      	
		// write $orphan_rule so we can figure out what is going on
		//fwrite($compiler, "%ORPHAN RULES\n");
		
		//foreach ($orphan_rule as $orphan){
		//	fwrite($compiler, "%".$orphan."\n");
		//}
		
		// now write out $dont_use
		//fwrite($compiler, "%DONT USE\n");
		
		//foreach ($dont_use as $orphan){
		//	fwrite($compiler, "%".$orphan."\n");
		//}
      	
       //for each rule
		foreach ($rules as $rule) {
			if (!(in_array($rule->rule_id, $orphan_rule))) {
            	fwrite($compiler, "\n");
            	$change_f0=$rule->category_id;
            	$change_t0=$rule->getRuleTransform();
            	unset($change_to);

            	//rewrite with category_id instead

            	//left
				$change_from = "c".$change_f0;

            	//right
            	$k = 0;
				foreach ($change_t0 as $change_t){
				   // check for the MDL category -- we don't include that when doing validation
 					if ($change_t->category_id != $modelCategoryId) {
						$change_to[$k] = "c".$change_t->category_id;
						$k++;
					}
            	}

            	//write the rule as comment
            	if ($comment){
            		fwrite($compiler, "%".$rule->rule_id."-->".$rule->category_id."\n");
            	}

            	// if X-->Xa

            	//become

            	//Xbis-->a, Xbis

            	//rXbis-->[]

            	if (in_array($change_from, $dont_use) && $change_from==$change_to[0]){
                  	fwrite($compiler, $change_from."bis --> ");

                  	for ($k = 1; $k < count($change_to); $k++){
                        fwrite($compiler, $change_to[$k].", ");
                  	}

                  	fwrite($compiler, $change_to[0]."bis.\n");

                  	//Xbis --> nothing

                  	fwrite($compiler, $change_to[0]."bis --> [].\n");

                  	//normal case
                  	//but check for the left recussives categories X--> b becomes X-->b, Xbis

            	} else {
                  	//left part

                  	fwrite($compiler, $change_from." --> ");

                  	//right part
					// Mandy -- let's see if we can rely on change_to instead of change_t0
                  	if (count($change_t0) == 0){
                  		fwrite($compiler, "[]. \n");
                  	} else {
                        //normal case

                  		for ($k = 0; $k < count($change_to); $k++){
                             fwrite($compiler, $change_to[$k]);

                             if($k < (count($change_to)-1)){
                             		fwrite($compiler, ", ");
                             }
                        }

                        //if rule is X-->b where X is part of the left, write X-->b, Xbis.

                        if (in_array($change_from, $dont_use)){
                        	fwrite($compiler, ", ".$change_from."bis");
                        }

                        fwrite($compiler, ".\n");
                  	}
            	}
			}	
      	}

      	fwrite($compiler, "\n");

      	//==================================================================
      	//PARTS SECTION
      	//==================================================================

      	fwrite($compiler, "%---------------PARTS---------------\n");
      	fwrite($compiler, "\n");
      	$dna_sequences="";

      	//for each category

      	foreach ($categories as $category) {
      		if (trim($category->letter) != 'MDL') {
            	//get cat info
            	$cat = "c".$category->category_id;

            	//get the parts of that category and from the chosen library
            	$parts = $dbParts->getPartsByLibraryCategory($libraryId, $category->category_id);

            	//for each part

            	foreach ($parts as $part) {
                	//#1: definition of the part type
                  	//give: part_type --> [name].

                  	$partout="p".$part->id;//.$cat[0];

                  	//write the part_type --> [name].  as comment
                  	if ($comment){
                        fwrite($compiler, "%".$category->letter."-->[".trim($part->description)."]\n");
                  	}

                    if(!in_array($cat, $dont_use)){
                    	fwrite($compiler, $cat." --> [".$partout."].\n");
                    } else {
                    	fwrite($compiler, $cat." --> [".$partout."], ".$cat."bis.\n");
                    }//involve X that has appeared in a rule X-->Xa|b
            	}        
            }
      	}

      	$part_ids = $library->getParts();
      	
      	foreach ($part_ids as $part_id) {
      		$part = $dbParts->find($part_id->part_id)->current();
      		
      		if ($part->part_id != 'empty') { 
				//#2: sequence
				//give: sequence(name, dna).
				//only one if oart is in several cat
					
				$sequence=strtolower($part->segment);

				$sequence=str_replace("\n","",$sequence);
				
				if (trim($sequence) != "") {
					// removing model parts
					$dna_sequences=$dna_sequences."sequence(p".$part->id.", '".trim($sequence)."').\n";
				}
			}
      	}	
	
      	fwrite($compiler, $dna_sequences."\n");

      	//%-------------------------------Write answer grammar-----------------------------
      	//will be written only if the grammar test has passed.

      	fwrite($compiler, "

      		%=====Answer grammar====

     		answer_grammar :- tell('result_".$randInt.".txt'), write('Verification grammar = true'),

                  nl, told.

      	\n");

       //=========================================================
       //     END
       //========================================================

       fclose($compiler);
       
       return $randInt;
	}	
	
	public static function doAttributeCompilation($design_id) {
		
		$dirName = Genocad_Utilities_Designs_Compiler::getCompilerDirectory();
		
		// get the library and grammar ids from the design_id
		$dbDesigns = new Application_Model_DbTable_Designs();
		$design = $dbDesigns->find($design_id)->current();
		$libraryId = $design->library_id;
		$grammar = $design->getLibrary()->getGrammar();
		$grammarId = $grammar->grammar_id;
		
		// build the design string for submission to the compiler
		$parts = $design->getDesignParts();
		$designParts = "[";
		
		foreach ($parts as $part){
			if (strlen($designParts) > 1){
				$designParts .= ",p".$part->part_id;
			} else {
				$designParts .= "p".$part->part_id;
			}
		}
		
		$designParts .= "]";
		
		$random = Genocad_Utilities_Designs_Compiler::buildCompilerAttribute($dirName, $libraryId, $grammarId);
		
		chmod($dirName."/compiler_".$random.".pl", 0777);
		
		$classpath = Zend_Registry::get('config')->compiler->classpath;
		$ldLibraryPath = Zend_Registry::get('config')->compiler->ld_library_path;

		//create script
		$script = fopen($dirName."/script_".$random, 'w') or die ("Cannot open the script file");
		fwrite($script, "pl -f ".$dirName."/compiler_".$random.".pl -g 'go($designParts),halt'\n");
		fwrite($script, "chmod 0777 $dirName/sbml.java\n");
		fwrite($script, "javac -classpath ".$classpath." $dirName/sbml.java\n");
		fwrite($script, "export LD_LIBRARY_PATH=".$ldLibraryPath."\n");
		fwrite($script, "export CLASSPATH=.:".$classpath."\n");
		fwrite($script, "cd $dirName\n");
		fwrite($script, "java sbml\n");
		$sbmlFileName = "sbml_".$random.".xml";
		$codeFileName = "code_".$random.".txt";
		fwrite($script, "mv sbml.xml ".$sbmlFileName."\n");
		fwrite($script, "mv code.txt ".$codeFileName."\n");
		fclose($script);
		
		//call script
		chmod("$dirName/script_".$random, 0777);
		shell_exec("cd $dirName; ./script_".$random);
		
		return(Array("SBML"=>$dirName."/".$sbmlFileName, "Equations"=>$dirName."/".$codeFileName, "Designs"=>$designParts));
	}
	
	public static function doValidationCompilation($grammarId, $libraryId, $dna) {
		
		// get compiler directory for the user
		$dirName = Genocad_Utilities_Designs_Compiler::getCompilerDirectory();
		
		// create the syntax directory if it does not exist
		if (!is_dir($dirName."/syntax")){
			exec("mkdir $dirName/syntax");
			chmod($dirName."/syntax", 0777);
		}
		
		$random = Genocad_Utilities_Designs_Compiler::buildCompilerNoOrphan($dirName, $libraryId, $grammarId);
		
		//test if the lexer can find an interpretation of the dna seq into parts from the given library
		exec("cd $dirName/syntax/;pl -f compiler_".$random.".pl -g ".'"dna2parts('."'".$dna."'),halt".'"');
		
		if (file_exists("$dirName/syntax/result_".$random.".txt")) {

			//if there is an interpretation(s), does it (one at least) follow grammar rules?

			unlink("$dirName/syntax/result_".$random.".txt");

			exec("cd $dirName/syntax/;pl -f compiler_".$random.".pl -g ".'"go('."'".$dna."'),halt".'"');

			//if dna seq can be broken done into parts
			if (file_exists("$dirName/syntax/result_".$random.".txt")){
				$valid = true;	
			} else {
		 		$valid = false; //"failed_grammar";//grammar didn't workd (but parts interpration did
			}
		} else {
			$valid = false; //["0"]="failed_parts";//parts cannot match the dna sequence
		}

		//delete files created
		unlink("$dirName/syntax/compiler_".$random.".pl");
		unlink("$dirName/syntax/result_".$random.".txt");
		//unlink("$root/compiler/compiler_$user_id/syntax/test.txt");
		return $valid;
	}
	
	public static function convertSemanticAction ($rule_id, $storedSemantic, $forSave) {
		// This converts the rule semantic action text in the database for display.  The format needs to be
		// the same as the format presented by Rule.php or else it will not convert back properly
		
		$dbRules = new Application_Model_DbTable_Rules();
		$dbCategories = new Application_Model_DbTable_Categories();
		
		$tempCategories = Array();
		
		$rule = $dbRules->find($rule_id)->current();
		
		$leftCategory = $rule->getCategory();
		
		// add left category to the tempCategories list so occurrences are handled correctly
		$tempCategories[$leftCategory->category_id] = array("totalCount" => 1);
		
		$ruleTransforms = $rule->getRuleTransform();
		
		foreach ($ruleTransforms as $transform) {
    		//first build array of categories so we know which ones are multiples
    		if (isset($tempCategories[$transform->category_id])) {
    			$tempCategories[$transform->category_id]["totalCount"] = $tempCategories[$transform->category_id]["totalCount"] + 1;
    		} else {
    			$tempCategories[$transform->category_id] = array("totalCount" => 1);
    		}
    	}
    	
    	// okay, go through again, this time adding to categories array
    	foreach ($ruleTransforms as $transform) {
    		$occuranceCount = 0;
    		// get the category
    		$category = $dbCategories->find($transform->category_id)->current();
    		
    		// check $tempCategories to see if there are multiple
    		if ($tempCategories[$category->category_id]["totalCount"] > 1) {
    			$occuranceCount = $tempCategories[$category->category_id]["totalCount"]-1;
    			$tempCategories[$category->category_id]["totalCount"] = $occuranceCount;
    			$occurrenceDispText = "-o".$occuranceCount;
    			$occurrenceSaveText = "o".$occuranceCount;
    		} else {
    			$occurrenceDispText= $occurrenceSaveText ="";
    		}
    		
    		// Add to array
    		if ($category->isRewritable()) {
    			$dispName = "^C-".$category->letter."^";
    			$saveName = "C".$category->category_id;
    		} else {
    			$dispName = "^Name-".$category->letter.$occurrenceDispText."^";
    			$saveName = "Name".$category->category_id.$occurrenceSaveText;
    		}

    		$transforms[] = array("saveName" => $saveName, "dispName" => $dispName);	

    		// now for attributes
    		$rsAttributes = $category->getAttributes();
    		foreach ($rsAttributes as $attribute) {
    			$dispName = "^A-".$attribute->name."(".$category->letter.")".$occurrenceDispText."^";
    			$saveName = "A".$attribute->id.$occurrenceSaveText;
    		
    			$transforms[] = array("saveName" => $saveName, "dispName" => $dispName);	
    		}		
    	}
    	
    	// Add the left occurrance last so for semantic replacement the appropriate transform is selected; otherwise, all of the instances
    	// will match the left-most occurrence if the left category appears also on the right
    	$transforms[] = array("saveName" => "C".$leftCategory->category_id, "dispName" => "^C-".$leftCategory->letter."^");
		
		// This may need to change, depending on what Laura decides about the left category
		$rsAttributes = $leftCategory->getAttributes();
		foreach($rsAttributes as $attribute) {
			$dispName = "^A-".$attribute->name."(".$leftCategory->letter.")^";
    		$saveName = "A".$attribute->id;
    		
    		$transforms[] = array("saveName" => $saveName, "dispName" => $dispName);
		}
		    	
		// Now replace all incidences of one name with the other in the text, depending on if we are saving or displaying the contents
    	foreach ($transforms as $trans) {
    		if ($forSave) {
    			// converting for save
    			$storedSemantic = str_replace($trans["dispName"], $trans["saveName"], $storedSemantic);
    		} else {
    			// converting for display
    			$storedSemantic = str_replace($trans["saveName"], $trans["dispName"], $storedSemantic);
    		}		
    	}

    	return($storedSemantic);
	}
}
?>
