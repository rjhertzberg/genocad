<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{

    protected function _initConfig()
    {
        Zend_Registry::set('config', new Zend_Config($this->getOptions()));
    }

    protected function _initViewSettings()
    {
        $view = new Zend_View();
        $view->addHelperPath('ZendX/JQuery/View/Helper/', 'ZendX_JQuery_View_Helper');
        $viewRenderer = new Zend_Controller_Action_Helper_ViewRenderer();
        $viewRenderer->setView($view);
        Zend_Controller_Action_HelperBroker::addHelper($viewRenderer);
    }

    public function run()
    {

        Zend_Session::start();

        // Here, we are going to check for the existance of the UserID session variable
        // which is set when it is determined that the user is logged in
        /*
        if (isset($_SESSION["UserID"])) {
            $dbUsers = new Application_Model_DbTable_Users();
            $storage = $dbUsers->find($_SESSION["UserID"])->current();
            Zend_Auth::getInstance()->getStorage()->write($storage);
        } else { 
            Zend_Auth::getInstance()->clearIdentity();
            $nsPartsList = new Zend_Session_Namespace('PartsList');
            $nsPartsList->resetSingleInstance();
        }
        */
        $frontController = Zend_Controller_Front::getInstance();
        $frontController->dispatch();
    }

}
