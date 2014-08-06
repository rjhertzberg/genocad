<?php
class Genocad_Utilities_Designs_Copasi
{
	public static function addChildAt(SimpleXMLElement $sxml, $tagname, $i) {     
		$parent = dom_import_simplexml($sxml);
		$child  = $parent->ownerDocument->createElement($tagname);
		$target = $parent->getElementsByTagname('*')->item($i);
		if ($target === NULL) {
			$parent->appendChild($child);
		} else { 
			$parent->insertBefore($child, $target);     
		} 
	}
	
	public static function callCopasi($sbmlFileName, $duration, $intervalLength) {
		// set config variables (Copasi home and Copasi executable)
		               
		$copasiHomeDir=Zend_Registry::get('config')->copasi->home_path;
		$copasiExecutable=Zend_Registry::get('config')->copasi->executable_path;
		$dirName = $dirName = Genocad_Utilities_Designs_Compiler::getCompilerDirectory();
		$dirName .= "/"; //getCompilerDirectory is not returning it.
				
		// calculate names of temporary files	
		$randInt = rand();
		$cpsFile="copasi_".trim($randInt).".cps";
		$cpsCallFile="copasi_call_".trim($randInt).".cps";
		$reportFile="timecourse_".trim($randInt).".txt";
		$reportName="Report_".trim($randInt);
		
		// Step 1: create the COPASI file from the sbml file.
		$cmd = '"'.$copasiExecutable.'" --home "'.$copasiHomeDir.'" -i "'.$sbmlFileName.'" -s "'.$dirName.$cpsFile.'"';
		shell_exec($cmd);
		
		// Step 2: Read the .cps file using SimpleXML
		if (file_exists($dirName.$cpsFile)) {
    		$xml = simplexml_load_file($dirName.$cpsFile);
    		
    		// Get the Model element (hopefully there is only one)
    		$modelName = $xml->Model["name"];
    		
    		// Make an array of compartments -- Needed for the Report element (associated with Metabolites)
    		$compartmentArray = Array();
    		
    		foreach($xml->Model->ListOfCompartments->Compartment as $compartment) {
    			$compartmentArray[(string) $compartment["key"]] = $compartment["name"];
    		}
    		    		
    		// Make an array of Metabolites -- also needed for the Report element
    		$metaboliteArray = Array();
    		$metaboliteIndex = 0;
    		
    		foreach($xml->Model->ListOfMetabolites->Metabolite as $metabolite) {
    			$metaboliteArray[$metaboliteIndex] = Array("name" => ((string) $metabolite["name"]), "compartment" => ((string) $metabolite["compartment"]));
    			$metaboliteIndex++;
    		}
    		
    		// Make an array of ModelValues -- maybe needed for the Report element 
    		$modelValueArray = Array();
    		$modelValueIndex = 0;
    		
    		foreach($xml->Model->ListOfModelValues->ModelValue as $modelValue) {
    			$modelValueArray[$modelValueIndex] = $modelValue["name"];
    			$modelValueIndex++;
    		}
 
    		// Find the timeCourse task
    		$taskKeyForTimeCourse = "";
    		foreach($xml->ListOfTasks->Task as $task) {
    			if ((string) $task["type"] == "timeCourse") {
    				$taskKeyForTimeCourse = $task["key"];
    				
    				// Need to change scheduled to true
    				$task["scheduled"] = "true";
    				
    				// Need to add Report line under the timeCourse task
    				Genocad_Utilities_Designs_Copasi::addChildAt($task, 'Report', 0);
    				$taskReport = $task->Report[0];
    				$taskReport->addAttribute('reference', $reportName);
    				$taskReport->addAttribute('target', $dirName.$reportFile);
    				$taskReport->addAttribute('append', '0');

    				// Need to set the parameters for the run -- the duration, length of interval, and number of intervals
    				$numIntervals = $duration/$intervalLength;
    				foreach($task->Problem->Parameter as $parameter) {
    					switch ((string) $parameter["name"]) {
    						case "StepNumber":
    							$parameter["value"] = $numIntervals;
    							break;
    						case "StepSize":
    							$parameter["value"] = $intervalLength;
    							break;
    						case "Duration":
    							$parameter["value"] = $duration;
    							break;		
    					}
    				}
    			}	
    		}
    		
    		if ($taskKeyForTimeCourse == ""){
    			// Didn't find task -- die
    			die("No task found for Time Course report.");
    		}
    		
    		// Add the report element
    		$tsReport = $xml->ListOfReports->addChild('Report');
    		$tsReport->addAttribute('key', $reportName);
    		$tsReport->addAttribute('name', "Particle Numbers, Volumes, and Global Quantity Values");
    		$tsReport->addAttribute('taskType', "timeCourse");
    		$tsReport->addAttribute('separator', chr(9));
    		$tsReport->addAttribute('precision', '6');
    		
    		// Add comment
    		$comment = $tsReport->addChild('Comment', " A table of time, all species particle numbers, all compartment volumes, and all global quantity values (includes fixed ones).");
    		$reportTable = $tsReport->addChild('Table');
    		$reportTable->addAttribute('printTitle', '1');
    		
    		//Add first line
    		$firstLine = $reportTable->addChild('Object');
    		$cnText = "CN=Root,Model=".$modelName.",Reference=Time";
    		$firstLine->addAttribute('cn', $cnText);
    		
    		//Add metabolites
    		foreach($metaboliteArray as $metabolite) {
    			$cnLine = $reportTable->addChild('Object');
    			$cnText = "CN=Root,Model=".$modelName.",Vector=Compartments[".
    						$compartmentArray[$metabolite["compartment"]].
    						"],Vector=Metabolites[".
    						$metabolite["name"]."],Reference=ParticleNumber";
    			$cnLine->addAttribute('cn', $cnText);			
    		}
    		
    		// Add Volume line for each compartment -- may remove
			//foreach($compartmentArray as $compartment) {
    		//	$cnLine = $reportTable->addChild('Object');
    		//	$cnText = "CN=Root,Model=".$modelName.",Vector=Compartments[".
    		//				$compartment.
    		//				"],Reference=Volume";
    		//	$cnLine->addAttribute('cn', $cnText);			
    		//}
    		
    		// Add ModelValues -- may remove
			//foreach($modelValueArray as $modelValue) {
    		//	$cnLine = $reportTable->addChild('Object');
    		//	$cnText = "CN=Root,Model=".$modelName.",Vector=Values[".
    		//				$modelValue.
    		//				"],Reference=Value";
    		//	$cnLine->addAttribute('cn', $cnText);			
    		//}
    		// Done adding report

    		// write new xml to new copasifile
    		$xml->asXML($dirName.$cpsCallFile);
    		
    		// now call the new COPASI file to see if it generates the report
    		$cmd = '"'.$copasiExecutable.'" --home "'.$copasiHomeDir.'" "'.$dirName.$cpsCallFile.'"';
    		shell_exec($cmd);
    		
		} else {
    		exit('Failed to open '.$sbmlFileName);
		}
		
		return($dirName.$reportFile);
	}
}
?>
