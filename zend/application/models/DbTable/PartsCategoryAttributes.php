<?php

class Application_Model_DbTable_PartsCategoryAttributes extends Zend_Db_Table_Abstract
{

    protected $_name = 'parts_category_attribute_assign';
    protected $_primary = 'id';
    protected $_rowClass = 'Application_Model_DbTable_Row_PartCategoryAttribute';

    protected $_referenceMap    = array(
        'CategoryAttributes' => array(
            'columns'           => 'category_attribute_id',
            'refTableClass'     => 'Application_Model_DbTable_CategoryAttributes',
            'refColumns'        => 'id',    
    		'onDelete'          => self::CASCADE
        ),
        'Parts' => array(
            'columns'           => 'part_id',
            'refTableClass'     => 'Application_Model_DbTable_Parts',
            'refColumns'        => 'id',
            'onDelete'          => self::CASCADE
        )
    );

    public function set($part_id, $attribute_id, $values) {

        $records = $this->fetchAll($this->select()->where('part_id = ?', $part_id)->where('category_attribute_id = ?', $attribute_id));
        foreach ($records as $current) {
            $current->delete();
        }

        if (is_array($values)) {
            foreach ($values as $value) {
                $data = array ('part_id' => $part_id, 'category_attribute_id' => $attribute_id, 'value'=> $value);
                $this-> insert($data);
            }
        } else {
            $data = array ('part_id' => $part_id, 'category_attribute_id' => $attribute_id, 'value'=> $values);
            $this-> insert($data);
        }        
    }
    
	public function clear($part_id) {
    	$records = $this->fetchAll($this->select()->where('part_id = ?', $part_id));
    	foreach ($records as $current) {
    			$current->delete();
    	}
    }
    
    public function clearForSave($part_id) {
    	$records = $this->fetchAll($this->select()->where('part_id = ?', $part_id));
    	$dbCategoryAttribute = new Application_Model_DbTable_CategoryAttributes();
    	foreach ($records as $current) {
    		$categoryAttribute = $dbCategoryAttribute->find($current->category_attribute_id)->current();
    		if ($categoryAttribute->attribute_type_id != 2) {
    			// don't want to clear the mapping values since they are saved separately
    			$current->delete();
    		}	
    	}
    }
    
	public function deletePartsValues($part_id) {
    	$records = $this->fetchAll($this->select()->where('value = ?', $part_id)
    											  ->orwhere('value like ?', '['.$part_id.",%"));
    	$dbCategoryAttribute = new Application_Model_DbTable_CategoryAttributes();
    	foreach ($records as $current) {
    		$categoryAttribute = $dbCategoryAttribute->find($current->category_attribute_id)->current();
    		if (($categoryAttribute->attribute_type_id == 1) || ($categoryAttribute->attribute_type_id == 2)) {
    			$current->delete();
    		}	
    	}
    }
    
    public function add ($part_id, $attribute_id, $value) {
    	$data = array('part_id' => $part_id, 'category_attribute_id' => $attribute_id, 'value'=>$value);
    	$this->insert($data);
    }
    
    //public function removeOrphans ($attribute_id) {
    	// deletes parts_category_attribute_assign values that were deleted by a change in the category_attribute
    //	$records = $this->fetchAll($this->select()->where('category_attribute_id = ? and category_id not in (select category_id from category_list_assigns where category_attribute_id = ?)', $attribute_id, $attribute_id));
    //	foreach ($records as $record) {
    //		$record->delete();
    //	}    	
    //}

}
?>
