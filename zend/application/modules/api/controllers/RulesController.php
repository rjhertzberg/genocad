<?php

class Api_RulesController extends Zend_Controller_Action
{

    public function init()
    {

        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('delete', 'json')
                      ->initContext('json');

    }

    public function deleteAction() {

        $id = $this->_request->getParam('rule_id');
        $dbRules = new Application_Model_DbTable_Rules();
        $dbRules->deleteRule($id);
        
    }
    
}
