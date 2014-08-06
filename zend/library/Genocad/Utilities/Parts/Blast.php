<?php
class Genocad_Utilities_Parts_Blast
{
	//Write the sequence given by the user in a file blastSearchSequence.fa
	public static function writeSequenceFile($fileSequence, $sequence){
		$fp = fopen($fileSequence,"w+");
		fputs($fp,"$sequence");
	}
	
	//Make a BLAST search with the command line
	public static function makeBlastSearch($searchType, $sequence, $fileResults, $queryFrom, $queryTo, $optimizeFor){
	    $blastPath = Zend_Registry::get('config')->blast->executable_path;
	    $blastDatabase = Zend_Registry::get('config')->blast->database;
		
		//Build searchable BLAST database from FASTA file
		if ($searchType!="") {
			$blastQuery = $blastPath.$searchType;
		} else {
			$blastQuery = $blastPath."blastn";
		}
		
		if (!(isset($optimizeFor)) || (trim($optimizeFor) == "")) {
			$optimizeFor = "megablast";
		}
			
		if (($queryFrom!="")&&($queryTo!="")) {
			$command = '"'.$blastQuery.'"'." -outfmt \"6 sseqid evalue bitscore qcovs\" -db ".$blastDatabase."genocad -task $optimizeFor -query $sequence -out $fileResults -query_loc $queryFrom-$queryTo";
		} else {
			$command = '"'.$blastQuery.'"'." -outfmt \"6 sseqid evalue bitscore qcovs\" -db ".$blastDatabase."genocad -task $optimizeFor -query $sequence -out $fileResults";
		}
		exec($command, $output, $status);
		
	}
	
	//Read the file where the blast results are written and put them in a tab
	public static function selectBlastResults($fileResults){
		//the file is read and each line is saved in a tab
		$file_array = file($fileResults);
	
		$part_array = array();
		foreach($file_array as $line){
			$tmpArray1 = explode("\t", $line);
			$tmpArray2 = explode("|", $tmpArray1[0]);
			$lineArray = array();
			$lineArray[] = $tmpArray2[0];
			if (count($tmpArray2) < 2) {
			//in the case the user_id was null
			$lineArray[] = "0";
			} else {
			$lineArray[] = $tmpArray2[1];
			}
			$lineArray[] = $tmpArray1[1];
			$lineArray[] = $tmpArray1[2];
			$lineArray[] = $tmpArray1[3];
			$part_array[] = $lineArray;
		}
		
		return $part_array;
	}
	
	public static function execBlastSearch($sequence, $queryFrom, $queryTo, $searchType, $optimizeFor) {
		$blastOutput = Zend_Registry::get('config')->blast->root;
		$random = rand();
		$fileSequence = $blastOutput."blastSearchSequence_".$random.".fa";
		$fileResults = $blastOutput."blastSearchResults_".$random.".out";
		Genocad_Utilities_Parts_Blast::writeSequenceFile($fileSequence, $sequence);
		Genocad_Utilities_Parts_Blast::makeBlastSearch($searchType, $fileSequence, $fileResults, $queryFrom, $queryTo, $optimizeFor);
		return Genocad_Utilities_Parts_Blast::selectBlastResults($fileResults);
	}
	
}
?>