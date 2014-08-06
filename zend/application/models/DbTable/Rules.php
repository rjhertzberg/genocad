<?php

class Application_Model_DbTable_Rules extends Zend_Db_Table_Abstract
{

    protected $_name = 'rules';
    protected $_primary = 'rule_id';
    protected $_dependentTables = array('Application_Model_DbTable_RuleSemanticActions', 'Application_Model_DbTable_RuleTransform');
    protected $_rowClass = 'Application_Model_DbTable_Row_Rule';
    
    protected $_referenceMap    = array(
        'Grammars' => array(
            'columns'           => 'grammar_id',
            'refTableClass'     => 'Application_Model_DbTable_Grammars',
            'refColumns'        => 'grammar_id'
        ),
        'Categories' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id'
        )
    );
    
    
    public function getRulesByGrammar($grammar_id) {

        $select  = $this->select()
                        ->where('grammar_id = ?', $grammar_id);

        return ($this->fetchAll($select));

    }

    /**
     * 
     * @param string $code
     * @param int $category_id
     * @param int $grammar_id
     * @param Array $transform
     */
    public function add ($code, $category_id, $grammar_id, $transform) {

        $dbRuleTransform = new Application_Model_DbTable_RuleTransform();

        $data = array (
            'code' => $code,
            'category_id' => $category_id,
            'grammar_id' => $grammar_id
        );

        $row = $this->createRow($data);
        $row->save();

        foreach ($transform as $key => $category) {
        	try {
        		$dbRuleTransform->add($row->rule_id, $category, $key);
        	} catch (Exception $e) {
        	} 
        }

        return ($row);
    }

    /**
     * 
     * @param unknown_type $rule_id
     */
    public function deleteRule ($rule_id) {
        $rows = $this->find($rule_id);
        foreach ($rows as $row) {
            $row->delete();
        }
    }

}
?>
