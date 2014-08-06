<?php
$file_result = "results3.out";
//the file is read and each line is saved in a tab
$file_array = file($file_result);
print_r($file_array);

foreach($file_array as $line) 
{  
	if ($line[1]='>') {
		$parts_number=$line[3];
		$i=4;
		$new_char=$line[i];
		while (is_numeric($new_char)):		
		$parts_number=$parts_number.$new_char;
		$i=$i+1;
		$new_char=$line[i];
		endwhile;
	    echo $parts_number ,'<br/>';
	}
}

?>