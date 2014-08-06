<?php
include('prepare_zend.php');

$dbDesigns = new Application_Model_DbTable_Designs();
$designs = $dbDesigns->fetchAll();

foreach ($designs as $design) {
    $message = $design->validate();
	print "user_id ".$design->user_id." design_id ".$design->design_id." ".$design->name." ".$message."\n\n";
}

print("done.");

?>
