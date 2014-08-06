<?php

class Api_LibraryController extends Zend_Controller_Action
{

    
    public function init()
    {
        $this->_helper->layout()->disableLayout();

        $ajaxContext = $this->_helper->getHelper('AjaxContext');
        $ajaxContext->addActionContext('detail', 'json')
                    ->addActionContext('mylibraries', 'json')
                    ->addActionContext('getlibraries', 'json')
                    ->addActionContext('getparts', 'json')
                    ->initContext('json');

        $context = $this->_helper->getHelper('contextSwitch');
        $context->addActionContext('getparts', 'json')
                ->initContext();
    }

    public function mylibrariesAction()
    {
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $gid = $this->_request->getParam('gid');

        $libraries = array();

        $libraryRows = $dbLibraries-> findMyLibraries($gid);

        foreach ($libraryRows as $libkey => $library) {
            $libraries[$libkey]["library_id"] = $library->library_id;
            $libraries[$libkey]["name"] = $library->name;
        }

        $this->view->libraries = $libraries;
    }

    public function getlibrariesAction()
    {
        $gid = $this->_request->getParam('gid');
        $this->view->library = Array();
        // instantiate the Libraries model and get the requested library record
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $libraries = $dbLibraries->getLibrariesByGrammar($gid, true, true);
        foreach ($libraries as $library) {
            $this->view->library[] = $library->toArray();
        }
        //$this->view->library = $dbLibraries->getLibrariesByGrammar($gid, true);

    }


    public function getpartsAction() {

        $library_id = $this->_request->getParam('library_id');
        $category_id = $this->_request->getParam('category_id');
        $this->view->parts = Array();

        // instantiate the Libraries model and get the requested library record
        $dbParts = new Application_Model_DbTable_Parts();
        $parts = $dbParts->getPartsByLibraryCategory($library_id, $category_id);
        //$this->view->parts = $parts;
        
        foreach ($parts as $part) {
            $part_arr = Array();
            $part_arr['part_id'] = $part->part_id;
            $part_arr['id'] = $part->id;
            $part_arr['description'] = $part->description; 
            $this->view->parts[] = $part_arr;//$part->toArray();
        }

    }

    public function detailAction()
    {
        // instantiate the Libraries model and get the requested library record
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $library = $dbLibraries->getLibrary($this->getRequest()->getParam('id'));
        //$json = $this->_helper->json->encodeJson($library->toArray());
        $this->view->library = $library->toArray();
        //$this->view->library = Zend_Json::encode($library->toArray());
    }


}





