<?php

class Application_Model_DbTable_RuleTransform extends Zend_Db_Table_Abstract
{

    protected $_name = 'rule_transform';
    protected $_primary = 'id';
    protected $_rowClass = 'Application_Model_DbTable_Row_RuleTransform';
    
    protected $_referenceMap    = array(
        'Rules' => array(
            'columns'           => 'rule_id',
            'refTableClass'     => 'Application_Model_DbTable_Rules',
            'refColumns'        => 'rule_id',
            'onDelete'          => self::CASCADE
        ),
        'Categories' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id'
        )
    );

    /**
     * 
     * @param unknown_type $rule_id
     * @param unknown_type $category_id
     * @param unknown_type $transform_order
     */
    public function add ($rule_id, $category_id, $transform_order) {

        $data = array (
            'rule_id' => $rule_id,
            'category_id' => $category_id,
            'transform_order' => $transform_order
        );

        $row = $this->createRow($data);
        $row->save();

    }
    
	public function getByRule ($rule_id) {
    	$records = $this->fetchAll($this->select()->where('rule_id = ?', $rule_id));
    	return($records);
    }

}
?>
