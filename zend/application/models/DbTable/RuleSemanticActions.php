<?php

class Application_Model_DbTable_RuleSemanticActions extends Zend_Db_Table_Abstract
{

    protected $_name = 'rule_semantic_action';
    protected $_primary = 'id';
    protected $_rowClass = 'Application_Model_DbTable_Row_RuleSemanticAction';

    protected $_referenceMap    = array(
        'Rules' => array(
            'columns'           => 'rule_id',
            'refTableClass'     => 'Application_Model_DbTable_Rules',
            'refColumns'        => 'rule_id',
            'onDelete'          => self::CASCADE
        )
    );
    
    public function getByRule ($rule_id) {
    	$records = $this->fetchAll($this->select()->where('rule_id = ?', $rule_id));
    	return($records);
    }
    
    public function add ($rule_id, $action) {
    	$data = array('rule_id' => $rule_id, 'action' => $action);
    	$row = $this->insert($data);
    	
    	return($row);
    }
}
?>
