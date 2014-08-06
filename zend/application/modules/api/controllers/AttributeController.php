<?php

class Api_AttributeController extends Zend_Controller_Action
{

    public function init()
    {

        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('get', 'json')
                      ->addActionContext('delete', 'json')
                      ->initContext('json');

    }

    public function getAction() {
        $id = $this->_request->getParam('id');
        $dbAttribute = new Application_Model_DbTable_CategoryAttributes();
        $attribute = $dbAttribute->find($id)->current();
        $this->view->attribute = $attribute->toArray();
    }

    public function deleteAction() {

        $id = $this->_request->getParam('id');
        $dbAttributes = new Application_Model_DbTable_CategoryAttributes();
        $attribute = $dbAttributes->find($id)->current();
        $attribute->delete();
        
    }
    
}
