<?php

class Application_Model_DbTable_Row_RuleSemanticAction extends Zend_Db_Table_Row_Abstract
{

    /**
     * @return Zend_Db_Table_Row
     */
    public function edit($rule_id, $action) {
        $data = array (
        	'id' => $this->id,
            'rule_id' => $rule_id,
            'action' => $action
        );

        $this->setFromArray($data);
        $this->save();
    }

}

?>