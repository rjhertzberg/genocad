
<?php

$path = $_SERVER['DOCUMENT_ROOT'];

include($path.'mysql_include.php');
include($path.'build_compiler_no_orphan.php');


function do_validation($grammar_id, $library_id, $user_id,$dna) {

global $server, $user, $pwd, $mydb, $root;

$dbsql=mysql_connect($server, $user, $pwd);
mysql_select_db($mydb, $dbsql);



//create workspace
if (!is_dir("$root/compiler/compiler_$user_id")){
	exec("mkdir $root/compiler/compiler_$user_id");
      chmod($root."compiler/compiler_$user_id", 0777);
}
if (!is_dir($root."compiler/compiler_$user_id/syntax")){
	exec("mkdir $root/compiler/compiler_$user_id/syntax");
	chmod($root."compiler/compiler_$user_id/syntax", 0777);
}

//clear workspce
unlink($root."compiler/compiler_$user_id/syntax/compiler.pl");
unlink($root."compiler/compiler_$user_id/syntax/result.txt");
unlink($root."compiler/compiler_$user_id/syntax/test.txt");


//call php function for the prolog compiler

build_compiler_no_orphan($dbsql, $grammar_id, $library_id, $user_id);//grammar id, library id

//test if the lexer can find an interpretation of the dna seq into parts from the given library
exec("cd $root/compiler/compiler_$user_id/syntax/;pl -f compiler.pl -g ".'"dna2parts('."'".$dna."'),halt".'"');

if (file_exists("$root/compiler/compiler_$user_id/syntax/result.txt")){

	//if there is an interpretation(s), does it (one at least) follow grammar rules?

	unlink("$root/compiler/compiler_$user_id/syntax/result.txt");

	exec("cd $root/compiler/compiler_$user_id/syntax/;pl -f compiler.pl -g ".'"go('."'".$dna."'),halt".'"');

	//if dna seq can be broken done into parts
	if (file_exists("$root/compiler/compiler_$user_id/syntax/result.txt")){

	return true;	


	}else{
		 return false; //"failed_grammar";//grammar didn't workd (but parts interpration did

	}
}else{
	return false; //["0"]="failed_parts";//parts cannot match the dna sequence

}


//delete files created
unlink("$root/compiler/compiler_$user_id/syntax/compiler.pl");
unlink("$root/compiler/compiler_$user_id/syntax/result.txt");
unlink("$root/compiler/compiler_$user_id/syntax/test.txt");


}

?>
