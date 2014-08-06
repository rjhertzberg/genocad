<?php

class Application_Model_DbTable_Row_DesignStep extends Zend_Db_Table_Row_Abstract
{

    public function getDesignStepParts() {
        $select = $this->select()->order(array('category_index'));
        return($this->findDependentRowset('Application_Model_DbTable_DesignStepParts', 'DesignSteps', $select));
    }

    
}