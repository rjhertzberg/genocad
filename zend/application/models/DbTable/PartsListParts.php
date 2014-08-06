<?php

class Application_Model_DbTable_PartsListParts extends Zend_Db_Table_Abstract
{

    protected $_name = 'partslist_parts';
    protected $_primary = array('partslist_id', 'part_id');

    protected $_referenceMap    = array(
        'Parts' => array(
            'columns'           => 'part_id',
            'refTableClass'     => 'Application_Model_DbTable_Parts',
            'refColumns'        => 'id',
            'onDelete'          => self::CASCADE
        )
    ); 
        
    public function getCart($partslist_id) {
    	$select = $this->select()->where('partslist_id = ?', $partslist_id);
    	if (Genocad_Application::isLoggedIn()) {
    		$select->where("part_id in (select id from parts where user_id in (0,?))", Genocad_Application::getUser()->user_id);
    	} else {
    		$select->where("part_id in (select id from parts where user_id = 0)");
    	}
    	
        return ($this->fetchAll($select));

    }
    
    public function addPart($cart_id, $part_id) {

        try {
            $data = array ('partslist_id' => $cart_id, 'part_id' => $part_id);
            $this-> insert($data);
        } catch (Exception $e) {
            // don't do anything here
        }
    }

    public function removePart($cart_id, $part_id) {

        $rows = $this->find($cart_id, $part_id);
        if ($rows) {
            $rows->current()-> delete();
        }

    }

}