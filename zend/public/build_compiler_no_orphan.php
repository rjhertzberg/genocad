<?php



 
//build a compiler only syntaxic: no attribute used at all
//grammar reduction
//left recursive rules rewritten
 

function build_compiler_no_orphan($db,$grammar_id,$library_id,$user_id){

 

      //change value to print comment in the prolog compiler file

      $comment=True;
global $root; 

 

      //======================================================

      //  INTRO, connect DB, open prolog file for compiler

      //=======================================================

 $compiler = fopen($root."compiler/compiler_$user_id/syntax/compiler.pl", 'w') or die ("Cannot open the prolog file");


 

      //==================================================================

      //   CONSTRUCTION OF THE PROLOG COMPILER

      //==================================================================

      fwrite($compiler, "%---------------COMPILER---------------\n");

 

 

      //%-------------------------------Intro-----------------------------

 

      fwrite($compiler, "%=====INTRO====\n");

 

      //

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

     

      write_dna(DNA_Sequence) :- tell('result.txt'),

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

                          tell('result.txt'),

                                      %write('DNA structure = '),

                                write(Tokens),

                                      nl, told.                     

      %printstructure(Tokens),nl.

     

      %printstructure([]).

      %printstructure([Head|Rest]) :- sequence(Head, Sequence), nl(Result), write(Result, Head), write(':'), write(Result, Sequence), nl(Result), printstructure(Rest).

      \n");

 

      //%-------------------------------Check grammar-----------------------------

 

      //grammar starts with S

 

      //get S id

     // $r=mysql_query("SELECT category_id FROM categories WHERE letter='S'AND grammar_id is NULL", $db); //old version of the DB
      $r=mysql_query("SELECT starting_category_id FROM grammars WHERE grammar_id=$grammar_id", $db);

      $start = mysql_fetch_array($r);

      $start = "c".$start[0];

 

      fwrite($compiler, "

      %=====CHECK GRAMMAR====

 

 

      check_grammar(Tokens) :- ".$start."(Tokens, []).

      \n");

 

 

      #1:find the set of rules we can use

 

      $finish=false;

      $orphan_rule=array();

      $o=0;

      //while we remove rules

      while (!$finish){

                 

            //for each rule of the modified set

            //query

            if (empty($orphan_rule)){

                  $rules = mysql_query("SELECT change_from, change_to, rule_id FROM rules WHERE grammar_id=$grammar_id", $db)

                  or die("Query 1.1 (grammar:$grammar_id) failed with error: ".mysql_error());

            }else{

                  $or = join(',',$orphan_rule);

                  $rules = mysql_query("SELECT change_from, change_to, rule_id FROM rules WHERE grammar_id=$grammar_id AND rule_id NOT IN ($or)", $db)

                  or die("Query 1.2 failed with error: ".mysql_error());

            }

 

            $finish=true;

 

 

 

            //

            //We compute "orphans" that store all symbole that are orphans (no parts and not involved in the left parts of a rule)

            $i=0;

 

            unset($orphans);

            $orphans = array();

 

 

            //for each category

            //if it has no parts attached

            //then get all the left side of the rules of this grammar.

            //if it is not in the left never, then never write a rule that uses this category

            //query for grammar's rules (come with letters of categories)

            $categorieso=mysql_query("SELECT letter, category_id FROM categories WHERE grammar_id=$grammar_id", $db);

 

            while($cato = mysql_fetch_array($categorieso)) {

 

                  $lettero=$cato[0];

                  $catido=$cato[1];

 

                  //get the parts of that actegory and from the chosen library

                  $partso = mysql_query("SELECT parts.id FROM parts, library_part_join, categories_parts WHERE parts.id=library_part_join.part_id AND library_id=$library_id AND parts.id=categories_parts.part_id AND categories_parts.category_id=$catido", $db);

 

                  //if this category has not part

                  if(mysql_num_rows($partso)==0){

                        //is it on the left of a rule?                 

                  if (empty($orphan_rule)){

                        $leftrules = mysql_query("SELECT * FROM rules WHERE grammar_id=$grammar_id and change_from='".$lettero."'", $db)

                        or die("Query 1.3 failed with error: ".mysql_error());

                  }else{

                        $or = join(',',$orphan_rule);

                        $leftrules = mysql_query("SELECT * FROM rules WHERE grammar_id=$grammar_id and change_from='".$lettero."' AND rule_id NOT IN ($or)", $db)

                        or die("Query 1.4 failed with error: ".mysql_error());

                  }

     

                        //$leftrules= mysql_query("SELECT * FROM rules WHERE change_from='$lettero' AND grammar_id=$grammar_id", $db);

 

                        if(mysql_num_rows($leftrules)==0){

                              $orphans[$i]=$lettero;

                              $i++;

                        }

                  }

            }

            //debug

            //    echo("Orphan:");

            //    for ($k = 0; $k < count($orphans); $k++){

 

            //          echo("$orphans[$k] - ");

 

            //    }

            //    echo("\n");

            //

 

            //for each rule

            while($rule = mysql_fetch_array($rules)) {

 

                  $change_f0=trim($rule[0]);

                  $change_t0=explode(" ", trim($rule[1]));

                  unset($change_to);      //very important

 

                  for ($k = 0; $k < count($change_t0); $k++){

 

                        if(in_array($change_t0[$k],$orphans)){

                              $orphan_rule[$o]=$rule[2];

                              $o=$o+1;

                              $finish=false;

                        }

                  }

            }//end while rules

      }//end while we remove rule

 

      //debug

      //echo("Orphan rule:");

      //for ($k = 0; $k < count($orphan_rule); $k++){

 

      //    echo("$orphan_rule[$k] - ");

 

      //}

      //echo("\n");

 

 

      //#3: We compute "don't use" that store all symbole that are involved in a rule type: X-->X,b

      //and compute the list of categories used by this grammar to avaoir useless declaration of parts

      $i=0;

      $dont_use = array();

      $y=0;

      $cat_used = array();

 

      //query for grammar's rules (come with letters of categories)

      if (empty($orphan_rule)){

            $rules = mysql_query("SELECT change_from, change_to FROM rules WHERE grammar_id=$grammar_id", $db)

            or die("Query 2.1 failed with error: ".mysql_error());

      }else{

            $or = join(',',$orphan_rule);

            $rules = mysql_query("SELECT change_from, change_to FROM rules WHERE grammar_id=$grammar_id AND rule_id NOT IN ($or)", $db)

            or die("Query 2.2 failed with error: ".mysql_error());

      }

 

      //for each rule

      while($rule = mysql_fetch_array($rules)) {

 

            $change_f0=trim($rule[0]);

            $change_t0=explode(" ", trim($rule[1]));

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

                  if (!in_array($change_t[0], $cat_used)){$cat_used[$y]=$change_t[0];$y++;}

            }

 

            if(count($change_to)>=2 && $change_from==$change_to[0]){

                  $dont_use[$i]=$change_from;

                  $i++;

            }

      }

 

 

      //#4: We write the rules paying attention to X-->X,b

      //we actually remove left recusrsion with the following principle

      //if X--> Xa|b

      //it becomes

      //X-->bX'

      //X'-->aX'|[]

 

 

      //query not orphan rules

      if (empty($orphan_rule)){

            $rules = mysql_query("SELECT change_from, change_to, rule_id FROM rules WHERE grammar_id=$grammar_id", $db)

            or die("Query 2.3 failed with error: ".mysql_error());

      }else{

            $or = join(',',$orphan_rule);

            $rules = mysql_query("SELECT change_from, change_to, rule_id FROM rules WHERE grammar_id=$grammar_id AND rule_id NOT IN ($or)", $db)

            or die("Query 2.4 failed with error: ".mysql_error());

      }

 

 

      //for each rule

      while($rule = mysql_fetch_array($rules)) {

 

            fwrite($compiler, "\n");

 

            $change_f0=trim($rule[0]);

            $change_t0=explode(" ", trim($rule[1]));

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

            }

                 

            //write the rule as comment

            if ($comment){fwrite($compiler, "%".$rule[0]."-->".$rule[1]."\n");}

 

 

            // if X-->Xa

            //become

            //Xbis-->a, Xbis

            //rXbis-->[]

            if(in_array($change_from, $dont_use) && $change_from==$change_to[0]){

                  fwrite($compiler, $change_from."bis --> ");

                  for ($k = 1; $k < count($change_to); $k++){

                        fwrite($compiler, $change_to[$k].", ");

                  }

                  fwrite($compiler, $change_to[0]."bis.\n");

                  //Xbis --> nothing

                  fwrite($compiler, $change_to[0]."bis --> [].\n");

 

 

 

 

                  //normal case

                  //but check for the left recussives categories X--> b becomes X-->b, Xbis

            }else{

 

                  //left part

                  fwrite($compiler, $change_from." --> ");

 

                  //right part

 

 

                  if ($change_t0[0]==null){fwrite($compiler, "[]. \n");

                  }else{

                        //normal case

 

                        for ($k = 0; $k < count($change_to); $k++){

                              //if(!in_array($change_to[$k], $dont_use)){

                              //fwrite($compiler, $change_to[$k]);}

                              //  else{fwrite($compiler, $change_to[$k]."bis");}//involve X that has appeared in a rule X-->X, X

                              //no that's a big mistake!!

                              fwrite($compiler, $change_to[$k]);

                              if($k<(count($change_to)-1)){fwrite($compiler, ", ");}

                        }

                        //if rule is X-->b where X is part of the left, write X-->b, Xbis.

                        if(in_array($change_from, $dont_use)){fwrite($compiler, ", ".$change_from."bis");}

                             

                        fwrite($compiler, ".\n");

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

 

      // $parts_used=array();//to avoid declaring the dna sequence multiple time as a parts can belong to several categories

      //$index=0;

 

      //for each category

      for ($k = 0; $k < sizeof($cat_used); $k++){

 

            //get cat info

            $r=mysql_query("SELECT * FROM categories WHERE category_id=$cat_used[$k]", $db);

            $cat = mysql_fetch_array($r);

            $cat[0] = "c".$cat[0];

 

            //get the parts of that actegory and from the chosen library

            $parts = mysql_query("SELECT parts.* FROM parts, library_part_join, categories_parts WHERE parts.id=library_part_join.part_id AND library_id=$library_id AND parts.id=categories_parts.part_id AND categories_parts.category_id=$cat_used[$k] AND parts.part_id!='empty'", $db);

 

            //$parts = mysql_query("SELECT parts.* FROM parts, library_part_join WHERE parts.id=library_part_join.part_id AND library_id=$library_id IN  (SELECT part_id FROM categories_parts WHERE category_id=$cat_used[k])", $db);

            //$parts = mysql_query("SELECT * FROM parts WHERE id=(SELECT part_id FROM library_part_join WHERE library_id=$library_id", $db);

 

 

            //for each part

 

            while($part = mysql_fetch_array($parts)) {

 

                  //#1: definition of the part type

                  //give: part_type --> [name].

 

                  $part[0]="p".$part[0];//.$cat[0];

 

                  //write the part_type --> [name].  as comment

                  if ($comment){

                        fwrite($compiler, "%".$cat[1]."-->[".trim($part[2])."]\n");}

 

                        if(!in_array($cat[0], $dont_use)){

                              fwrite($compiler, $cat[0]." --> [".$part[0]."].\n");

                        }else{

                              fwrite($compiler, $cat[0]." --> [".$part[0]."], ".$cat[0]."bis.\n");}//involve X that has appeared in a rule X-->Xa|b

 

                              //#2: sequence

                              //give: sequence(name, dna).

                              //if (!in_array($part[0], $parts_used)){

                              //$part[3]=strtolower($part[3]);

 

                            //  $part[3]=str_replace("\n","",$part[3]);

                             // $dna_sequences=$dna_sequences."sequence(".$part[0].", '".trim($part[3])."').\n";

                              //$parts_used[$index]=$part[0];

                              //$index++;

                              //}

 

            }

      }

      $seqs = mysql_query("SELECT parts.* FROM parts, library_part_join WHERE parts.id=library_part_join.part_id AND library_id=$library_id AND parts.part_id!='empty'", $db);
		while($seq = mysql_fetch_array($seqs)) {
		//#2: sequence
					//give: sequence(name, dna).
					//only one if oart is in several cat
					
					$seq[3]=strtolower($seq[3]);

					$seq[3]=str_replace("\n","",$seq[3]);
					$dna_sequences=$dna_sequences."sequence(p".$seq[0].", '".trim($seq[3])."').\n";
					
			
		}
	




      fwrite($compiler, $dna_sequences."\n");

 

 

 

 

      //%-------------------------------Write answer grammar-----------------------------

      //will be written only if the grammar test has passed.

 

      fwrite($compiler, "

      %=====Answer grammar====

     

      answer_grammar :- tell('result.txt'), write('Verification grammar = true'),

                      nl, told.

      \n");

 

 

 

      //=========================================================

      //     END

      //========================================================

 

 

 

 

      fclose($compiler);

 

 

}

 

?>

 

 

 
