<?php

class HelpController extends Zend_Controller_Action
{

    public function init()
    {
        $this->_helper->layout()->disableLayout();
    }

    public function indexAction()
    {

        $module = $this->getRequest()->getParam('mod');
        $controller = $this->getRequest()->getParam('ctlr');
        $action = $this->getRequest()->getParam('act');
        
        $file_name = APPLICATION_PATH . '/../public/help-files/' . $module . '-' . $controller . '-' . $action  . '.html';
        $this->view->file_contents = file_get_contents($file_name);
       /*$this->view->file_name = $file_name;

        if (file_exists($file_name)) {
            $this->view->file_exists = 'true';
            $this->view->file_contents = file_get_contents($file_name);
        } else {
            $this->view->file_exists = 'false';
        }
*/
    }


}

