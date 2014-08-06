<?php

class Application_Model_DbTable_CodeTbgenerated extends Zend_Db_Table_Abstract
{

    protected $_name = 'code_tbgenerated';
    protected $_primary = 'id';
    protected $_rowClass = 'Application_Model_DbTable_Row_CodeTbgenerated';

    protected $_referenceMap    = array(
        'Grammars' => array(
            'columns'           => 'grammar_id',
            'refTableClass'     => 'Application_Model_DbTable_Grammars',
            'refColumns'        => 'grammar_id',
            'onDelete'          => self::CASCADE
        )
    );
    
    /**
     * Deletes existing code_tbgenerated rows in anticipation of inserting new ones.
     * 
     * @param Integer $grammar_id
     * @returns boolean
     */
    public function clearCodeTbgenerated ($grammar_id) {
    	$records = $this->fetchAll($this->select()->where('grammar_id = ?', $grammar_id));
    	foreach ($records as $current) {
    			$current->delete();
    	}
    	
    	return(true);
    }
    
    public function add ($grammar_id, $type, $code) {
    	$data = array('grammar_id' => $grammar_id, 'type' => $type, 'code'=>$code);
    	$this->insert($data);
    }
}
?>
