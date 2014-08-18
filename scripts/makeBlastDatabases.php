<?php
$indexPath = "/opt/blast/";
$blastExec ='"/opt/ncbi-blast-2.2.29+/bin/makeblastdb"';
$blastIndex = '/opt/blast/data/';
$server = "localhost";
$username="genofab";
$password="2aC4uRv4aL1hYn4poz7er2ghakS4Og2I2";
$database="genofab";

$db = connectToDB($server, $username, $password, $database);

makeBlastDb($blastIndex, $blastExec, $db, "genocad", $database);

echo "Finished!";
mysql_close();

//Open connection to database
function connectToDB($server, $username, $password, $database) {
	//$dbsql=mysql_connect($server, $username, $password); 

    $dbsql= mysql_connect($server, $username,$password, $database);
    
	//@mysql_select_db($database) or die( "Unable to select database");
	
	if (!$dbsql) {
	    die('Could not connect to the database: ' . mysql_error());
	}

	echo "Connected successfully to the database!<br />";
	
	return $dbsql;
}

//Convert parts in database to string of fastas
function databasePartsToFastaString($db, $database){
	
	$fastaString = "";
	
	//mysql_select_db($database, $db);
	mysql_select_db($database);
	
	$query = "SELECT CONCAT('>',part_id,'|',user_id,'\n',segment,'\n') FROM parts WHERE CHAR_LENGTH(segment) > 2";

	//Grab parts from db
	//if($r = mysql_query($query,$db)){
	if($r = mysql_query($query)){
		
		echo "Query succeeded.<br />";
		
    	//$fastaArray = mysql_fetch_array($r);
	
		//Make one large FASTA string of all parts
		while($fasta = mysql_fetch_array($r)){
		
			$fastaString .= $fasta[0];
		}
		return $fastaString;
	}else{
		echo "Query failed.<br />";
	}
}

//Make a BLAST database out of GenoCAD parts in GenoCAD database
function makeBlastDb($blastIndex, $blastExec, $db, $fileName, $database){
	
	//Produce string of fastas from database
	$fastaString = databasePartsToFastaString($db, $database);
	
	//Write file containing fastas
	file_put_contents($blastIndex.$fileName, $fastaString);
	
	//Build searchable BLAST database from FASTA file
	$command = $blastExec." -in ".$blastIndex."$fileName -dbtype nucl -out ".$blastIndex."$fileName";
	
//	system($command, $output);

	exec($command, $output, $status);
	
	$str_out = print_r($output);
	
	
	echo "Command output: ".$str_out."<br />";
	echo "Command status: ".$status."<br />";
	
}



?>
