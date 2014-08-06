<?php 
		$server = "localhost2";
		$user = "genocad";
		$pwd = "Test";
		$mydb = "genocad_zend";
		
		global $server, $user, $pwd, $mydb;
		$dbsql=mysql_connect($server, $user, $pwd);
		mysql_select_db($mydb, $dbsql);
		
		$sql = "select d.design_id, d.design_json, d.terminals_json, g.grammar_id from designs d, libraries l, grammars g ".
			" where d.user_id < 50 and d.design_id not in (select distinct design_id from design_steps) ".
			" and length(d.terminals_json) > 0 and length(d.design_json) > 0 ".
			" and l.library_id = d.library_id and g.grammar_id = l.grammar_id";
		
		
		 
?>
<html>
	<head>
		<title>Migrate designs</title>
	</head>
	<body>
		<p>Design JSON view:</p>
		
		<?php
			echo "<p>Beginning memory: ".memory_get_usage()."</p>";
			 
		//for ($i=360; $i < 500; $i++){
			
		//	$sql = "select d.design_id, d.design_json, d.terminals_json, g.grammar_id from designs d, libraries l, grammars g ".
		//	" where d.design_id = ".$i." and d.design_id not in (select distinct design_id from design_steps) ".
		//	" and length(d.terminals_json) > 0 and length(d.design_json) > 0 ".
		//	" and l.library_id = d.library_id and g.grammar_id = l.grammar_id";
			$dr = mysql_query($sql, $dbsql);
			unset($sql);
			echo "<p>After selecting dr: ".memory_get_usage()."</p>";
			while ($row = mysql_fetch_array($dr)) {
				$jsonArray2 = json_decode($row["design_json"]);
				$designId = $row["design_id"];
				echo "<p>Design Id".$designId."</p>";
				$grammarId = $row["grammar_id"];
				$terminalArray = json_decode($row["terminals_json"]);
				unset($row);
				
				
				// Go through the steps from the design_json row and insert into the database.
				$lastStepId = 0;
				$step = 0; 
				foreach ($jsonArray2 as $json) {
					$sql = "insert into design_steps (step_index, design_id) ".
						"values (".$step.",".$designId.")";
					$s = mysql_query($sql);
					$stepId = mysql_insert_id();
					
					//mysql_free_result($s);
					$lastStepId = $stepId;
			
					$order = 0;
					$elements = $json->{'elements'};
		    		unset($json);
		    				    	
					foreach ($elements as $element) {
						$sql = "select category_id from categories where letter = '".$element."' and grammar_id = ".$grammarId;
						$s = mysql_query($sql);
						unset($sql);
						if ($catRow = mysql_fetch_array($s)) {
							$categoryId = $catRow["category_id"];
						
					        $sql = "insert into design_step_parts (step_id, category_index, category_id) ".
								"values (".$stepId.",".$order.",".$categoryId.")";
							$r = mysql_query($sql);
							//mysql_free_result($r);
						} else {
							echo "<p>ERROR: Category Letter ".$element." for design ".$designId." could not be found.</p>";
						}	
						
						mysql_free_result($s);
						$order += 1;
						unset($element);
					}
					$step += 1;	
					unset($elements);
				}
				unset($jsonArray2);

				// Using the lastStepId, make an array of orders and categories -- the parts number should match the number of items in the last category row.
				$sql = "select * from design_step_parts where step_id = ".$lastStepId." order by category_index";
				$s = mysql_query($sql);
			
				unset($sql);
				$categoryArray = Array();
				while ($srow = mysql_fetch_array($s)){
					$categoryArray[$srow["category_index"]] = Array("category_index" => $srow["category_index"], "category_id" => $srow["category_id"], "part_id" => "null");
					unset($srow);
				}
								
				mysql_free_result($s);

				// get the values from terminals_json
				if (count($terminalArray) != count($categoryArray)) {
					echo "<p>ERROR:Terminal_json for design ".$designId." does not have the right number of elements</p>";
				} else {
					// Now we'll step through the terminalArray and add steps for the parts.
					// first, query for the parts
					$arrayIndex = 0;
					
					while ($arrayIndex < count($terminalArray)){
						$terminalPart = trim($terminalArray[$arrayIndex]);
					
						// Skip blank parts
						if (strlen($terminalPart) > 0) {
							// see if we can identify the part
							$sql = "select p.id from parts p, categories_parts cp ".
								" where p.part_id = '".$terminalPart."' and cp.part_id = p.id and cp.category_id = ".$categoryArray[$arrayIndex]["category_id"];
							$s = mysql_query($sql);
						
							unset($sql);
							if ($srow = mysql_fetch_array($s)) {
								// able to find at least one part
								$categoryArray[$arrayIndex]["part_id"] = $srow["id"];
							
								// only add a step if the part is set
								$sql = "insert into design_steps (step_index, design_id) ".
									"values (".$step.",".$designId.")";
								$r = mysql_query($sql);
								unset($sql);
								$stepId = mysql_insert_id();
								//mysql_free_result($r);
						
								$step += 1;
							
								// now loop through the categories and insert for each category under the new step
								foreach ($categoryArray as $categoryElement) {
									$sql = "insert into design_step_parts (step_id, category_index, category_id, part_id) ".
										"values (".$stepId.",".$categoryElement["category_index"].",".$categoryElement["category_id"].",".$categoryElement["part_id"].")";
									$r = mysql_query($sql);
									mysql_free_result($r);
									unset($categoryElement);
								}
							} else {
								echo "<p>ERROR: Missing part ".$terminalPart." for design ".$designId." in position ".$arrayIndex."</p>";
							}
							
							mysql_free_result($s);
						}
						$arrayIndex += 1;
					}
				}
				unset($categoryArray);
				unset($terminalArray);
				echo "Done! ".memory_get_usage();
			}
			mysql_free_result($dr);
			
		//}							
		?>
	</body>
</html>
