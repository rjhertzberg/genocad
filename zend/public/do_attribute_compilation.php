<html><body>
<?php
include('build_compiler_attribute.php');
include('mysql_include.php');


$dbsql=mysql_connect($server, $user, $pwd); 
mysql_select_db($mydb, $dbsql);


$user_id=0;
//create user's dir
if (!is_dir("$root/compiler/compiler_$user_id")){	
	exec("mkdir $root/compiler/compiler_$user_id");
    chmod("$root/compiler/compiler_$user_id", 0777);
}

$design=$_POST['design'];

//call php function for the prolog compiler

build_compiler_attribute($dbsql,911,911, $user_id);
chmod("$root/compiler/compiler_$user_id/compiler.pl", 0777);


//create script
$script = fopen("$root/compiler/compiler_$user_id/script", 'w') or die ("Cannot open the script file");
fwrite($script, "pl -f $root/compiler/compiler_$user_id/compiler.pl -g 'go($design),halt'\n");
fwrite($script, "chmod 0777 $root/compiler/compiler_$user_id/sbml.java\n");
fwrite($script, "javac -classpath /usr/local/share/java/libsbmlj.jar $root/compiler/compiler_$user_id/sbml.java\n");
fwrite($script, "export LD_LIBRARY_PATH=/usr/local/lib/\n");
fwrite($script, "export CLASSPATH=.:/usr/local/share/java/libsbmlj.jar\n");
fwrite($script, "cd $root/compiler/compiler_$user_id\n");
fwrite($script, "java sbml");
fclose($script);


//call script
chmod("$root/compiler/compiler_$user_id/script", 0777);
shell_exec("cd $root/compiler/compiler_$user_id/; ./script");




?>
</body></html>
