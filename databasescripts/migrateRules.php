<?php 
		$server = "localhost";
		$user = "genocad";
		$pwd = "Test";
		$mydb = "genocad_prod";
		
		global $server, $user, $pwd, $mydb;
		$dbsql=mysql_connect($server, $user, $pwd);
		mysql_select_db($mydb, $dbsql);
		
		$sql = "select * from rules_old";
		
		
		 
?>
<html>
	<head>
		<title>Migrate rules</title>
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
			
			while ($row = mysql_fetch_array($dr)) {
				// first insert rule into new rules table; ideally we will keep old rule_id because otherwise will need to update rule_semantic
				$grammarId = $row["grammar_id"];
				$ruleId = $row["rule_id"];
				$sql = "insert into rules (rule_id, code, category_id, grammar_id) ".
						"select ".$ruleId.", '".$row["code"]."', category_id, grammar_id ".
						"from categories where letter = '".trim($row["change_from"])."' and grammar_id = ".$grammarId;
				$ir = mysql_query($sql);
				
				// Okay, now do the rule_transform row
				$categories = explode(" ", trim($row["change_to"]));
				$count = 0;
				foreach ($categories as $category){
					if ($category != '') {
						$count += 1;
						
						$sql = "insert into rule_transform (rule_id, category_id, transform_order) ".
								"select ".$ruleId.", category_id, ".$count." from categories ".
								"where letter = '".$category."' and grammar_id = ".$grammarId;
						$irt = mysql_query($sql);
					}
				}
				echo "<p> Rule ".$ruleId." transformed; memory_usage = ".memory_get_usage()."</p>";
			}			
		?>				
			
	</body>
</html>