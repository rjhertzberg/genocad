<?php

class Api_CategoryController extends Zend_Controller_Action
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
        $dbCategory = new Application_Model_DbTable_Categories();
        $category = $dbCategory->find($id)->current();
        $this->view->category = $category->toArray();
        $this->view->category["image_url"] = $category->getImageUrl();
        $qualifier = $category->getGenbankQualifier();
        if ($qualifier) {
            $this->view->category["genbank_qualifier"] = $qualifier->qualifier;
        } else {
            $this->view->category["genbank_qualifier"] = "";
        }
    }

    public function deleteAction() {

        $id = $this->_request->getParam('category_id');
        $dbCategories = new Application_Model_DbTable_Categories();
        $dbCategories->deleteCategory($id);
        
        $this->view->message = "The category has been deleted";
        
    }
    
}
