<?php

class Application_Model_DbTable_CategoryAttributes extends Zend_Db_Table_Abstract
{

    protected $_name = 'category_attribute';
    protected $_primary = 'id';
    protected $_rowClass = 'Application_Model_DbTable_Row_CategoryAttribute';
    protected $_dependentTables = array('Application_Model_DbTable_PartsCategoryAttributes', 'Application_Model_DbTable_CategoryAttributeLists');

    protected $_referenceMap    = array(
        'Categories' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id'
        )
    );
    
	public function add ($category_id, $name, $description, $display_order, $attribute_type_id, $categoriesListAssigns) {

		$dbAttributesListAssigns = new Application_Model_DbTable_CategoryAttributeLists();
		
        $data = array (
            'category_id' => $category_id,
            'name' => $name,
        	'description' => $description,
        	'display_order' => $display_order,
        	'attribute_type_id' => $attribute_type_id
        );

        $row = $this->createRow($data);
        $row->save();
        
        if ($attribute_type_id > 0) {
        	// don't save categories for attribute_type numeric
        	foreach ($categoriesListAssigns as $category_id) {
        		$dbAttributesListAssigns->addCategory($row->id, $category_id);
        	}
        }

        // Check for existing parts -- interface assumes that there is some value defined for each attribute
        $dbCategories = new Application_Model_DbTable_Categories();
        $dbPartsCategoryAttributes = new Application_Model_DbTable_PartsCategoryAttributes();
        $category = $dbCategories->find($category_id)->current();
        $parts = $category->getParts();
        
        if (($row->attribute_type_id == 0) || ($row->attribute_type_id == 0)) {
        	foreach ($parts as $part) {
        		$dbPartsCategoryAttributes->set($part->id, $row->id, "");
        	}
        }	

        return ($row);
    }
    
}