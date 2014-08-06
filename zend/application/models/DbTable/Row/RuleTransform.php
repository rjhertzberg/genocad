<?php

class Application_Model_DbTable_Row_RuleTransform extends Zend_Db_Table_Row_Abstract
{

    /**
     * @return Zend_Db_Table_Row
     */
    public function getCategory() {
        return ($this->findParentRow('Application_Model_DbTable_Categories'));
    }

}