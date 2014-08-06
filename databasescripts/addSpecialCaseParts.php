<?php 
		$server = "localhost";
		$user = "genocad";
		$pwd = "Test";
		$mydb = "genocad_prod";
		
		global $server, $user, $pwd, $mydb;
		$dbsql=mysql_connect($server, $user, $pwd);
		mysql_select_db($mydb, $dbsql);
		
		$sql = "select * from grammars";
		
		
		 
?>
<html>
	<head>
		<title>Add special case parts</title>
	</head>
	<body>
		<p>Add special case parts:</p>
		
		<?php
			echo "<p>Beginning memory: ".memory_get_usage()."</p>";
			 
		//for ($i=360; $i < 500; $i++){
			
		//	$sql = "select d.design_id, d.design_json, d.terminals_json, g.grammar_id from designs d, libraries l, grammars g ".
		//	" where d.design_id = ".$i." and d.design_id not in (select distinct design_id from design_steps) ".
		//	" and length(d.terminals_json) > 0 and length(d.design_json) > 0 ".
		//	" and l.library_id = d.library_id and g.grammar_id = l.grammar_id";
			$dr = mysql_query($sql, $dbsql);
			unset($sql);
			
			while ($row = mysql_fetch_array($dr)) {
				// get the grammar id so we can retrieve the special case categories
				$grammarId = $row["grammar_id"];
				echo "<p> Adding special parts for grammar ".$row["name"]."</p>";
								
				$sql = "select * from categories where letter in ('[', ']', '(', ')', '{', '}') and grammar_id=".$grammarId;
				$cat = mysql_query($sql);
				unset($sql);	
				
				while ($catrow = mysql_fetch_array($cat)) {
					echo "<p> Category ".$catrow["letter"]." for ".$row["name"]."</p>";
					
					// first thing we we do is check to see if the part is already there
					$sql = "select * from categories_parts where user_id = ".$row["user_id"]." and category_id = ".$catrow["category_id"];
					$cp = mysql_query($sql);
					unset($sql);
					
					$part_id = 0;
					while ($cprow = mysql_fetch_array($cp)){
						$part_id = $cprow["part_id"];
					}
					
					if ($part_id == 0) {
						$partName = "";
						// none found, need to add
						switch ($catrow["letter"]) {
							case '[': $partName = "Opening Reverse Complement Delimiter"; break;
							case ']': $partName = "Closing Reverse Complement Delimiter"; break;
							case '(': $partName = "Opening Plasmid Delimiter"; break;
							case ')': $partName = "Closing Plasmid Delimiter"; break;
							case '{': $partName = "Opening Chromosome Delimiter"; break;
							case '}': $partName = "Closing Chromosome Delimiter"; break;
						}
						
						// insert into parts, get id
						$sql = "insert into parts(part_id, description, segment, user_id) values ('z".$catrow["category_id"]."', '".$partName."', '".$catrow["letter"]."', ".$row["user_id"].")";
						$s = mysql_query($sql);
						$part_id = mysql_insert_id();
						unset($sql);
						
						// now insert categories_parts record
						$sql = "insert into categories_parts (category_id, part_id, user_id) values (".$catrow["category_id"].", ".$part_id.", ".$row["user_id"].")";
						$s = mysql_query($sql);
						unset($sql);
					} 
					
					// try to add library_part_join records for every library and part.  If the row already exists,
					// it will fail to add, but we'll catch the error.
					
					$sql = "select * from libraries where grammar_id = ".$grammarId;
					$lib = mysql_query($sql);
					unset($sql);

					while ($librow = mysql_fetch_array($lib)) {
						try {
							$sql = "insert into library_part_join(library_id, part_id) values (".$librow["library_id"].",".$part_id.")";
							$test = mysql_query($sql);
							unset($sql);
						} catch (Exception $e) {
							
						}
					}
				}
			}		
		?>				
			
	</body>
</html>