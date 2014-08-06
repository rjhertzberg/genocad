<?php
class Genocad_Utilities_Designs_ReverseComplement
{
	public static function reverse_complement($sequence) {
     	// reverse reversePrimer 
	    $reversePrimer = strrev(strtoupper($sequence));
	        		
	    // do the mass replacement 
	        		
	    // start by replacing a's with something bogus */
	    $reversePrimer = str_replace('A', 'Z', $reversePrimer);
	        		
	    // replace the t's with a's */
	    $reversePrimer = str_replace('T', 'A', $reversePrimer);
	        		
	    // replace the bogus's with t's */
	    $reversePrimer = str_replace('Z', 'T', $reversePrimer);
	        		
	    // start by replacing c's with something bogus */
	    $reversePrimer = str_replace('C', 'Z', $reversePrimer);
	        		
	    // replace the g's with c's */
	    $reversePrimer = str_replace('G', 'C', $reversePrimer);
	        		
	    // replace the bogus's with g's */
	    $reversePrimer = str_replace('Z', 'G', $reversePrimer);
	    
	    return $reversePrimer;
     }
     
     public static function reverse_parts($partString) {
     	$forwardArray = explode("|", $partString);
     	$reverseArray = Array();
     	
     	while (count($forwardArray) > 0) {
     		$tempVal = trim(array_pop($forwardArray));
     		if ($tempVal != "") {
     			array_push($reverseArray, $tempVal);
     		}	
     	}
     	
     	return("_|".implode("|", $reverseArray)."|_");
     }
     
     public static function sequence_reverse($sequence) {
     	$sequence = strtoupper($sequence);
     	$frontBracketPos = strpos($sequence, "[");
     	
     	if (!($frontBracketPos === false)){
     		
     		$reverseBracketOffset = $frontBracketPos + 1;
     		$frontBracketOffset = $frontBracketPos + 1;
     		
     		while ($reverseBracketOffset >= $frontBracketOffset) {
     			$reverseBracketPos = strpos($sequence, "]", $reverseBracketOffset);
     			$frontBracketTemp = strpos($sequence, "[", $frontBracketOffset);
     			
     			if (!(($frontBracketTemp === false) || ($reverseBracketPos === false))) {
     				if ($reverseBracketPos > $frontBracketTemp) {
     					// there is something in between
     					$reverseBracketOffset = $reverseBracketPos + 1;
     					$frontBracketOffset = $frontBracketTemp + 1;
     				} else {
     					// found reversePos -- break loop
     					$reverseBracketOffset = 0;
     					$frontBracketOffset = 1;
     				}
     			} else {	
     				// reached end -- break loop
     					$reverseBracketOffset = 0;
     					$frontBracketOffset = 1;
     			}
     		}
     		
     		$subString = substr($sequence, $frontBracketPos+1, $reverseBracketPos - $frontBracketPos - 1);
     		$subString2 = Genocad_Utilities_Designs_ReverseComplement::reverse_complement(Genocad_Utilities_Designs_ReverseComplement::sequence_reverse($subString));
     		
     		return substr($sequence,0,$frontBracketPos).$subString2.Genocad_Utilities_Designs_ReverseComplement::sequence_reverse(substr($sequence,$reverseBracketPos+1));
     	} else {
     		return $sequence;
     	}	
     }
     
     /**
      * Function: reverse_parts_genbank
      * Purpose: calculate the order of parts for the Features section so we know which ones to add the complement in
      * 		 and add the features section in the right order
      * Returns: array or string of indexes
      */
     
     public function reverse_parts_genbank($partsString) {
     	// This array may be a subsection of the total array
     	
     	$tempString = $partsString;
     	$frontBracketPos = strpos($tempString, "[");
     	
     	if (!($frontBracketPos === false)){
     		
     		$reverseBracketOffset = $frontBracketPos + 1;
     		$frontBracketOffset = $frontBracketPos + 1;
     		
     		while ($reverseBracketOffset >= $frontBracketOffset) {
     			$reverseBracketPos = strpos($tempString, "]", $reverseBracketOffset);
     			$frontBracketTemp = strpos($tempString, "[", $frontBracketOffset);
     			
     			if (!(($frontBracketTemp === false) || ($reverseBracketPos === false))) {
     				if ($reverseBracketPos > $frontBracketTemp) {
     					// there is something in between
     					$reverseBracketOffset = $reverseBracketPos + 1;
     					$frontBracketOffset = $frontBracketTemp + 1;
     				} else {
     					// found reversePos -- break loop
     					$reverseBracketOffset = 0;
     					$frontBracketOffset = 1;
     				}
     			} else {	
     				// reached end -- break loop
     					$reverseBracketOffset = 0;
     					$frontBracketOffset = 1;
     			}
     		}
     		
     		$subString = substr($tempString, $frontBracketPos+1, $reverseBracketPos - $frontBracketPos - 1);
     		$subString2 = Genocad_Utilities_Designs_ReverseComplement::reverse_parts(Genocad_Utilities_Designs_ReverseComplement::reverse_parts_genbank($subString));
     		
     		return substr($tempString,0,$frontBracketPos).$subString2.Genocad_Utilities_Designs_ReverseComplement::reverse_parts_genbank(substr($tempString,$reverseBracketPos+1));
     	} else {
     		return $tempString;
     	}	
     }
     
     /**
      * Function: sequence_divide
      * Purpose: calculate the sequence, start and end, and name for each of the plasmids and chromosomes in a sequence
      * Returns: Array, where each entry has the name of the plasmid, the start of the plasmid, and the sequence
      */
     public static function sequence_divide ($design_name, $sequence) {
     	$basePlasmidName = $design_name."_p".substr($design_name, 0, 4);
     	$baseChromosomeName = $design_name."_Chr";
     	
     	$returnArray = Array();
     	$plasmidArray = Array();
     	$chromosomeArray = Array();
     	
     	$returnCount = 0;
     	$plasmidCount = 0;
     	$chromosomeCount = 0;
     	$positionCounter = 0;
     	
     	// Go ahead and add entry for the complete sequence
     	$returnArray[$returnCount] = $design_name."|design|";
     	for($i = 0; $i < strlen($sequence); $i++) {
     		$testChar = substr($sequence, $i, 1);
     		
     		switch ($testChar) {
     			case "(":
     			// new plasmid
     				$plasmidArray[$plasmidCount] = $basePlasmidName.($plasmidCount+1)."|".$positionCounter."|";
     				$plasmidCount += 1;
     				break;
     			case "{":
     			// new chromosome	
     				$chromosomeArray[$chromosomeCount] = $baseChromosomeName.($chromosomeCount+1)."|".$positionCounter."|";
     				$chromosomeCount += 1;
     				break;
     			case ")":
     			// end plasmid	
     				for ($j=($plasmidCount-1);$j >= 0; $j--) {
     					if (substr($plasmidArray[$j], strlen($plasmidArray[$j]) - 1, 1) != 'd') {
     						$plasmidArray[$j] .= "|d";
     						break;
     					}
     				}
     				break;
     			case "}": 
     			// end chromosome	
     				for ($j=($chromosomeCount-1);$j >= 0; $j--) {
     					if (substr($chromosomeArray[$j], strlen($chromosomeArray[$j]) - 1, 1) != 'd') {
     						$chromosomeArray[$j] .= "|d";
     						break;
     					}
     				}
     				break;
     			default:
     				$returnArray[$returnCount] .= $testChar;
     				$positionCounter += 1;
     				
     				// update any Chromosomes that are not terminated
     				if ($chromosomeCount > 0) {
     					for ($j = 0; $j < $chromosomeCount; $j++) {
     						if (substr($chromosomeArray[$j], strlen($chromosomeArray[$j]) - 1, 1) != 'd') {
     							$chromosomeArray[$j] .= $testChar;
     						}
     					}
     				}
     				
     				// update any Plasmids that are not terminated
     				if ($plasmidCount > 0) {
     					for ($j = 0; $j < $plasmidCount; $j++) {
     						if (substr($plasmidArray[$j], strlen($plasmidArray[$j]) - 1, 1) != 'd') {
     							$plasmidArray[$j] .= $testChar;
     						}
     					}
     				}
     				break;				
     		}
     	}
     	
     	// Terminate the design string
     	$returnArray[$returnCount] .= "|d";
     	
     	// Load chromosomes into the array
     	foreach ($chromosomeArray as $chromosome) {
     		if (substr($chromosome, strlen($chromosome) - 1, 1) == 'd') {
     			// only return properly terminated chromosomes
     			$returnCount += 1;
     			$returnArray[$returnCount] = $chromosome;
     		}	
     	}
     	
     	// Load plasmids into the array
     	foreach ($plasmidArray as $plasmid) {
     		if (substr($plasmid, strlen($plasmid) - 1, 1) == 'd') {
     			//only return properly terminated plasmids
     			$returnCount += 1;
     			$returnArray[$returnCount] = $plasmid;
     		}	
     	}
     	
     	return $returnArray;
     }
     
     public function genbankExport ($designName, $designDesc, $designId, $libraryId, $grammarId, $requestCategories, $requestTerminals) {
     	
     	$terminals = explode("|", $requestTerminals);
        $dbParts = new Application_Model_DbTable_Parts();
        $parts = Array();
        $partIndex = 0;
        $partIndexString = "";
        $sequence = "";

        foreach ($terminals as $terminal) {
            $part = $dbParts->find($terminal)->current();
            $parts[] = $part;
            if (trim($part->segment) != "") {
            // we skip blank parts, usually associated with MDL parts	
            	if (($part->segment == '[') || ($part->segment == ']')) {
            		$tempVal = $part->segment;
            	} else {
            		$tempVal = $partIndex;	
            	} 
            	if ($partIndex > 0) {
            		$partIndexString .= "|".$tempVal;
            	} else {
            		$partIndexString .= $tempVal;	
            	}
            	$partIndex++;
            	$sequence .= strtolower($part->segment);
        	}
        }	
        
        $partIndexArray = explode("|", Genocad_Utilities_Designs_ReverseComplement::reverse_parts_genbank($partIndexString));

        $sequence = strtolower(Genocad_Utilities_Designs_ReverseComplement::sequence_reverse($sequence));
        
        

       // need to get the categories from the database to check 
       // the genbank qualifiers
       $dbCategories = new Application_Model_DbTable_Categories();
       $categories = Array();         
       foreach (explode("|",$requestCategories) as $category) {
       			$tempCategory = $dbCategories->find($category)->current();
       			if ($category->letter != "MDL") {
       				// model parts have no sequence, so they can't be features
       				$categories[] = $tempCategory;	
       			}
                 
       }

       $staticElementArray = Array();
            
       // get intregal bits from the database
       if ($designId != NULL){
          $dbDesigns = new Application_Model_DbTable_Designs();
          $design = $dbDesigns->find($designId)->current();

          $staticElementArray["mod_date"] = date("d-M-Y", strtotime($design->last_modification));
          $staticElementArray["design_name"] = $design->name;
          $staticElementArray["definition"] = trim($design->name).'.';
          $staticElementArray["comment"] = $design->description;

       } else {

          $staticElementArray["mod_date"] = date("d-M-Y");
          $staticElementArray["design_name"] = " ";
          $staticElementArray["definition"] = ".";
          $staticElementArray["comment"] = "";
       }
            
       // requery sequenceArray because the name is undefined above
       // second pass to remove the () and {}
       $sequenceArray = Genocad_Utilities_Designs_ReverseComplement::sequence_divide($staticElementArray["design_name"], strtolower($sequence));
       $tempSequence = explode('|',$sequenceArray[0]);
       $sequence = $tempSequence[2];

       $db = Zend_Db::factory(Zend_Registry::get('config')->resources->db);

       $total_base_pairs = strlen($sequence);
       $staticElementArray["total_base_pairs"] = $total_base_pairs;

       $genbankFileString = "";
       $lastLineNumber = 1;

       $dbGenbankSpecs = new Application_Model_DbTable_GenbankSpecs();
       $select = $dbGenbankSpecs->select()
                                ->where('line_number < 8')
                                ->order(array('line_number', 'start_position'));

       $specs = $dbGenbankSpecs->fetchAll($select);

       foreach ($specs as $spec) {

       		// writing out non-repeatables
            if ($spec->line_number > $lastLineNumber) {
            	// time to change lines
                $genbankFileString .=  PHP_EOL;
                $lastLineNumber = $spec->line_number;
            }

            $length = 1 + ($spec->end_position - $spec->start_position);
        
            // if the value field is not null, then we write that value; otherwise, we get the value from staticElementArray
            $linebreak = 0;

            if ($spec->value != NULL){
               	if ($spec->value == "(blank)")
               		$writeValue = " ";
                else 
                    $writeValue = $spec->value;                 
           	} else {
            	if ($spec->field_name == "comment") {
                	$linebreak = 1;
            	}
                $writeValue = $staticElementArray[$spec->field_name];
           	}
        
            // TODO: will eventually need to handle scenario where the length of the definition is longer than the 
            // total field, but for now just make sure you don't exceed the length allotted on a single line
            if ($linebreak == 0){
            	if ($spec->justification == "L") {
                	$genbankFileString .= str_pad(substr(trim($writeValue), 0, $length), $length, " ", STR_PAD_RIGHT); 
            	} else {
                	$genbankFileString .= str_pad(substr(trim($writeValue), 0, $length), $length, " ", STR_PAD_LEFT);
                }
           	} else {
            	// a linebreak line needs to be indented to the 13th position and end with a period.
                // The first time through, will have the title -- after that, need to preface with blanks
                // also do not want line break to occur in the middle of a word.

                $writeValue = trim(str_replace(PHP_EOL, " ", $writeValue));

                $writeValueLength = strlen($writeValue);
                if (substr($writeValue, $writeValueLength - 1, 1) != '.') {
                	$writeValue .= '.';
                	$writeValueLength += 1;
                } 

                $posStart = 0;

                while ($posStart < $writeValueLength) {

                // get position of last space in the substring between $posStart and $posEnd
                	if (($posStart + 67) >= $writeValueLength) {
                    	$posEnd = 67;
                    } else {
                    	$posEnd = strripos(substr($writeValue, $posStart, 67), ' ');
                        if (!$posEnd) {
                        	$posEnd = 67;
                        }
                    }   

                    $genbankFileString .= substr($writeValue, $posStart, $posEnd);

                    $posStart += $posEnd;

                    while (($posStart < $writeValueLength) && (substr($writeValue, $posStart, 1) == ' ')) {
                    	$posStart += 1;
                    }

                    if ($posStart < $writeValueLength) {
                    	// more to write
                        $genbankFileString .= PHP_EOL.str_pad(' ', 12, ' ', STR_PAD_RIGHT);
                    }
                 }
            }
        }
        $genbankFileString .= PHP_EOL;

        // features
        // When you get to line numbers 7 and 8, those can be repeated (and 8 can be repeated under 7, though I don't anticipate
        // doing that.

        // start with source -- covers the entire design
        // 1-5 -- blanks
        $genbankFileString .= str_pad(' ', 5, ' ', STR_PAD_RIGHT);
        // 6-20 -- category key -- left-justified
        $genbankFileString .= str_pad('source', 15, ' ', STR_PAD_RIGHT);
        // 21 -- space
        $genbankFileString .= ' ';
        // 22-80 base pairs clause -- gets more detailed, but for now just start..stop
        $genbankFileString .= "1..".$total_base_pairs.PHP_EOL;

        if (count($parts) == count($categories)) {

        	// see if there are more features we can use
        	$baseCounter = 0;
        	$dbGenbankQualifers = new Application_Model_DbTable_GenbankQualifiers();
                
        	// Add plasmids and chromosomes -- need to adjust so that they come in source order, but will
        	// handle that later
        	$featuresArray = array();
        	foreach ($sequenceArray as $tempSequence) {
            	$lines = explode("|", $tempSequence);
                if ($lines[1] != "design") {
                	$tempLine = "";
                		
                	$cpStart = $lines[1] + 1;
                	$cpEnd = strlen($lines[2]) + $lines[1];
                	if (!(($cpStart == 1) AND ($cpEnd == $total_base_pairs))) {
                		// 1-5 blanks
                		$tempLine .= str_pad(' ', 5, ' ', STR_PAD_RIGHT);
                		// 6-20 source -- left-justified
                		$tempLine .=  str_pad('source', 15, ' ', STR_PAD_RIGHT);
                		// 21 space
                		$tempLine .= ' ';
                		// 22-80 base pairs clause
                		$tempLine .= $cpStart."..".$cpEnd.PHP_EOL;
                	}	
                		
                	// next line, 21 blanks
                	$tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                		
                	$cpName = $lines[0];
                	// check to see if chromosome or plasmid
                	$tempPos = strrpos($lines[0], '_');
                	if (substr($lines[0], $tempPos+1, 1) == 'p') {
                		// plasmid
                		$tempLine .= '/plasmid="'.$cpName.'"'.PHP_EOL;
                	} else {
                		$tempLine .= '/chromosome="'.$cpName.'"'.PHP_EOL;
                	}
                		
                	while (array_key_exists($cpStart, $featuresArray)) {
                		$cpStart += 1;
                	}
                	$featuresArray[$cpStart] = $tempLine; 
                		
                }
         	}

         	
            for ($j = 0; $j < count($partIndexArray); $j++) {
            	$i = $partIndexArray[$j];

                if (is_numeric($i)) {
                    // we need to check the segment length if only for the baseCounter
                    $part = $parts[$i];
                    $partLength = strlen(trim(str_replace(array("{","}","[","]","(",")"), "", $part->segment)));
                    $category = $categories[$i];
                    $tempLine = "";

                    // check to see if the part in question's category has a qualifier
                    if ($category->genbank_qualifier_id != '') {

                        // get the genbank qualifier from the database
                        $qualifier = $dbGenbankQualifers->find($category->genbank_qualifier_id)->current();

                        // 1-5 blanks
                        $tempLine .= str_pad(' ', 5, ' ', STR_PAD_RIGHT);
                        
                        // 6-20 -- category key -- left-justified
                        $tempLine .= str_pad(trim(substr($qualifier->qualifier, 0, 15)), 15, ' ', STR_PAD_RIGHT);
                        
                        // 21 -- space
                        $tempLine .= ' ';
                        
                        // 22-80 base pairs clause -- gets more detailed, but for now just start..stop
                        $baseStart = $baseCounter + 1;
                        $baseEnd = $baseCounter + $partLength;
                        if ($j < (count($partIndexArray) - 1)) {
                        	if ($i > $partIndexArray[$j+1]) {
                        		// need to check for numeric
                        		$tempLine .= "complement(".$baseStart."..".$baseEnd.")".PHP_EOL;
                        	} else {
                        		$tempLine .= $baseStart."..".$baseEnd.PHP_EOL;
                        	}
                        } else {
                        	$tempLine .= $baseStart."..".$baseEnd.PHP_EOL;
                        }	
                        
                        // Add additional qualifier info
                        // label
                        $tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                        $tempLine .= '/label="'.substr($part->description, 0, 50).'"'.PHP_EOL;
                        $tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                        $tempLine .= '/note="GenoCAD Category: '.$category->description.'"'.PHP_EOL;
                        if (strlen(trim($part->description_text)) > 0){
                            $tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                            
                            $tempLine .= '/note="'.substr($part->description_text, 0, 50).'"'.PHP_EOL;
                        }
                        
                        $cpStart = $baseStart;
                        while (array_key_exists($cpStart, $featuresArray)) {
                			$cpStart += 1;
                		}
                		$featuresArray[$cpStart] = $tempLine;                           
                    }
                    $baseCounter += $partLength;
                }
            }
                
            // write the featuresArray
            ksort($featuresArray);
            foreach($featuresArray as $feature){
            	$genbankFileString .= $feature;
            }
       	}

       	// Now add origins line
       	$genbankFileString .= "ORIGIN".PHP_EOL;

       	// Now add sequence
       	$lineNumber = 1;

       	while ($lineNumber <= $total_base_pairs) {
       		$genbankFileString .= str_pad($lineNumber, 9, ' ', STR_PAD_LEFT).' ';
    
       		$tempString = str_pad(substr($sequence, $lineNumber - 1, 60), 60, ' ', STR_PAD_RIGHT);
    
        	$genbankFileString .= chunk_split($tempString, 10, " ") . PHP_EOL;

        	$lineNumber += 60;                                    
        }

        $genbankFileString .= "//";

        return($genbankFileString);
     	
     }
}     
?>
