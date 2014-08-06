<?php

class Application_Model_DbTable_Row_PartCategoryAttribute extends Zend_Db_Table_Row_Abstract
{

    public function getPart() {
        $dbParts = new Application_Model_DbTable_Parts();
        return($dbParts->getPart(trim($this->value)));
    }
    
    public function edit($part_attribute_id, $part_id, $attribute_id, $value) {
    	$data = array (
                    'id' => $part_attribute_id,
                    'part_id' => $part_id,
                    'category_attribute_id' => $attribute_id,
                    'value' => $value
        );

        $this->setFromArray($data);
        $this->save();
    }
}