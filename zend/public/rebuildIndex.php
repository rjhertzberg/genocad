<?php 
	$server_name = 'genocad-dev.vbi.vt.edu'; 
?>
<html>
	<head>
		<title>Rebuild Lucene Index</title>
	</head>
	<body>
		<p>Rebuilding Lucene Index</p>
		
		<?php
			echo "<p>Starting update ...</p>";
			echo "<p>Start time: ".date('l jS \of F Y h:i:s A T')."</p>";
			//exec("php /srv/www/vhosts/".$server_name."/htdocs/no-ssl/scripts/create_lucene_index.php");
			echo"<p>End time: ".date('l jS \of F Y h:i:s A T')."</p>";
			echo"<p>Lucene Index Build complete</p>";							
		?>
	</body>
</html>
