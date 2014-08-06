<?php

class Application_Model_DbTable_PartsList extends Zend_Db_Table_Abstract
{

    protected $_name = 'partslist';
    protected $_primary = 'id';


    public function emptyParts($id) {
        $dbPartsListParts = new Application_Model_DbTable_PartsListParts();
        $where = $dbPartsListParts->getAdapter()->quoteInto('partslist_id = ?', $id);
        $dbPartsListParts->delete($where);
    }

    public function getPartsListbyUserID($user_id) {

        $where = $this->getAdapter()->quoteInto('user_id = ?', $user_id);
        $row = $this->fetchRow($where);

        // if there is no row, the simply add one and return it
        if (!$row) {
            $data = array(
				'user_id' => $user_id,
			    'created_on' => new Zend_Db_Expr('NOW()'),
			    'updated_on' => new Zend_Db_Expr('NOW()')
            );
            $this->insert($data);
            $where = $this->getAdapter()->quoteInto('user_id = ?', $user_id);
            $row = $this->fetchRow($where);
        }

        return $row;
    }
    
    public function getParts($id) {

        $dbPartsListParts = new Application_Model_DbTable_PartsListParts();
        return ($dbPartsListParts->getCart($id));

    }

    // This function will add multiple parts to a given Parts List.  The $parts is an array of part_ids.
    public function addParts($id, $parts) {

        foreach ($parts as $part) {
            $this->addPart($id, $part);
        }

    }

    // This function will add a single part to the Parts List 
    public function addPart($id, $part_id) {

        $partlist_part = new Application_Model_DbTable_PartsListParts();
        $partlist_part->addPart($id, $part_id);

    }

    // This function will add multiple parts to a given Parts List.  The $parts is an array of part_ids.
    public function removeParts($id, $parts) {
        if (is_array($parts)) {
            foreach ($parts as $part) {
                $partlist_part = new Application_Model_DbTable_PartsListParts();
                $partlist_part->removePart($id, $part);
            }
        } else {
            $partlist_part = new Application_Model_DbTable_PartsListParts();
            $partlist_part->removePart($id, $parts);
        }


    }

    
    /**
     * Returns a set of grammar records that are associated with parts in the given "Cart"
     * 
     * @param Integer $id - "Cart" id - primary key of the partslist record 
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getGrammars($id) {

    	if (Genocad_Application::isLoggedIn()) {
        	$sql = sprintf('grammar_id in (select grammar_id from v_parts_browser v, partslist_parts plp where v.id = plp.part_id and plp.partslist_id = %s and v.part_user_id in (0, %s))', $id, Genocad_Application::getUser()->user_id);
    	} else {
    		$sql = sprintf('grammar_id in (select grammar_id from v_parts_browser v, partslist_parts plp where v.id = plp.part_id and plp.partslist_id = %s and v.part_user_id = 0)', $id);
    	}
    	
        $dbGrammars = new Application_Model_DbTable_Grammars();
        //$select = $dbGrammars->select()->where('grammar_id in (select grammar_id from v_parts_browser v, partslist_parts plp where v.id = plp.part_id and plp.partslist_id = ? and v.part_user_id in (0, 80))', $id);
        $select = $dbGrammars->select()->where($sql);
    	$grammars = $dbGrammars->fetchAll($select);
        
        return ($grammars);

    }

    /**
     * Returns a set of category records that are associated with parts in the given cart
     * for the given grammar only
     * 
     * @param Integer $id - "Cart" id - primary key of the partslist record
     * @param Integer $grammar_id - the primary key of the grammar record
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getCategories($id, $grammar_id) {
    	if (Genocad_Application::isLoggedIn()) {
        	$sql = sprintf('category_id in (SELECT category_id FROM v_parts_browser p, partslist_parts plp where p.grammar_id = %s and p.id = plp.part_id and plp.partslist_id = %s and p.part_user_id in (0, %s))', $grammar_id, $id, Genocad_Application::getUser()->user_id);
    	} else {
    		$sql = sprintf('category_id in (SELECT category_id FROM v_parts_browser p, partslist_parts plp where p.grammar_id = %s and p.id = plp.part_id and plp.partslist_id = %s and p.part_user_id = 0)', $grammar_id, $id);
    	}
        $dbCategories = new Application_Model_DbTable_Categories();
        $categories = $dbCategories->fetchAll($dbCategories->select()->where($sql));
        return ($categories);

    }
}
