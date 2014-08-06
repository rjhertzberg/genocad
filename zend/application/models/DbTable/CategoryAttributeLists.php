<?php

class Application_Model_DbTable_CategoryAttributeLists extends Zend_Db_Table_Abstract
{

    protected $_name = 'category_attribute_list_assign';
    protected $_primary = 'id';

    protected $_referenceMap    = array(
        'CategoryAttributes' => array(
            'columns'           => 'category_attribute_id',
            'refTableClass'     => 'Application_Model_DbTable_CategoryAttributes',
            'refColumns'        => 'id',
    		'onDelete'          => self::CASCADE
        ),
        'Categories' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id',
        	'onDelete'          => self::CASCADE
        )
    );
    
    public function addCategory($attribute_id, $category_id) {

		$data = array ('category_attribute_id' => $attribute_id, 'category_id' => $category_id);
		try {
			$this-> insert($data);
		} catch (Exception $e) {
			// don't do anything here -- just trying to duplicate entry
		}	

	}

    public function removeCategory($attribute_id, $category_id) {

    	$rows = $this->find($attribute_id, $category_id);
        if ($rows) {
        	$rows->current()->delete();
        }
    }

}