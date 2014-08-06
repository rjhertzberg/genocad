<?php

class SearchController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
        $this->view->headTitle("GenoCAD: Search");
        $this->view->headScript()->appendFile('/js/jstree/jquery.jstree.js');
        $this->view->headScript()->appendFile('/js/dataTables-1.7/media/js/jquery.dataTables.js');
        $this->view->headScript()->appendFile('/js/dataTables.fnReloadAjax.js');
        $this->view->headScript()->appendFile('/js/parts_browser.js');
        $this->view->headScript()->appendFile('/js/tiptip/jquery.tipTip.js');
        $this->view->headScript()->appendFile('/js/jquery.multiselect2side.js');
        
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_page.css');
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_table_jui.css');
        $this->view->headLink()->appendStylesheet('/css/parts_list.css');
        $this->view->headLink()->appendStylesheet('/js/tiptip/tipTip.css');
        $this->view->headLink()->appendStylesheet('/js/jquery.multiselect2side.css');
        $this->view->headLink()->appendStylesheet('/css/parts_list.css');

     
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('delete', 'json')
                      ->addActionContext('save', 'json')
                      ->initContext('json');

    }

    public function indexAction()
    {
 
        $advanced = ($this->getRequest()->getParam('advanced', 0) == 1);
        $blast = ($this->getRequest()->getParam('blast', 0) == 1);
        $basic = !($advanced || $blast);
        $dbSearch = new Application_Model_DbTable_UserSearches();

        if (Genocad_Application::isLoggedIn()) {
            $this->view->saved_searches = $dbSearch->findUserSearches();
        }
        
        // If this is a basic search, then check to see if the user loaded a saved search
        if ($basic) {

            $search_id = $this->getRequest()->getParam('search_id', 0);

            if ($search_id != 0) {
                // load the saved search model and find the query
                $search = $dbSearch->find($search_id)->current();
                $this->view->query = $search->query;
            } else {
                // otherwise, the user got here by searching from the text box
                // at the top of each page
                $this->view->query = $this->getRequest()->getParam('query', "");
            }

        }

        $this->view->advanced = $advanced == 1;
        $this->view->blast = $blast == 1;
        $this->view->search_id = $this->getRequest()->getParam('search_id', 0);        

    }

    public function saveAction()
    {

        // disable the layout because this is going to return a JSON object
        $this->_helper->layout()->disableLayout();

        $dbSearch = new Application_Model_DbTable_UserSearches();

        // retrieve the name and query paramters submitted by the user
        $name = $this->getRequest()->getParam('name');
        $query = $this->getRequest()->getParam('query');

        // if the name or query was not provided, flash an error
        if ($query == "" || $name == "") {
            $this->view->status = "error";
            $this->view->message = "You must provide a Name and a Query for the Saved Search.";
            return;
        }
    
        $existing = $dbSearch->findUserSearchbyName($name);

        if (count($existing) > 0) {
            $search = $existing->current();

            $data = array (
                    'search_id' => $search->search_id,
                    'name' => $name,
                    'query' => $query
            );

            $search->setFromArray($data);
            $search->save();
            $id = $search->search_id;
        } else {
            $id = $dbSearch->add($name, $query);
        }

        $this->view->status = "success";
        $this->view->message = "The Search was saved successfully.";
        $this->view->search_id = $id;

    }

    public function deleteAction()
    {

        // disable the layout because this is going to return a JSON object
        $this->_helper->layout()->disableLayout();

        $dbSearch = new Application_Model_DbTable_UserSearches();

        // retrieve the saved search being deleted
        $search = $dbSearch->find($this->getRequest()->getParam('search_id'))->current();
        $search->delete();

        $this->view->status = "success";
        $this->view->message = "The Saved Search has been removed.";

    }

    public function createAction()
    {
        // action body
        $indexPath = Zend_Registry::get('config')->search->lucene_index_path;
        Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_TextNum());
        $index = Zend_Search_Lucene::create($indexPath);
        $index->optimize();
/*
        $dbParts = new Application_Model_DbTable_Parts();
        $parts = $dbParts->fetchAll($dbParts->select()->where('id <= 500'));

        foreach ($parts as $part) {
    
            $doc = new Zend_Search_Lucene_Document();
            $doc->addField(Zend_Search_Lucene_Field::Keyword('part_id_pk', $part->id));
            $doc->addField(Zend_Search_Lucene_Field::UnStored('sequence', $part->segment));
            $doc->addField(Zend_Search_Lucene_Field::Text('part_id', $part->part_id));
            $doc->addField(Zend_Search_Lucene_Field::Text('part_name', $part->description));
            $doc->addField(Zend_Search_Lucene_Field::Text('user_id', $part->user_id));
            $doc->addField(Zend_Search_Lucene_Field::Text('description', $part->description_text));

            $rsCategories = $part->getCategories();
            $part_category = "";
            foreach ($rsCategories as $category) {
                $cat = $category->findParentRow('Application_Model_DbTable_Categories');
                $part_category .= $cat->grammar_id . '|' . $cat->letter . '|' . $cat->description . ';';
            }

            $doc->addField(Zend_Search_Lucene_Field::Text('category', $part_category));

            $index->addDocument($doc);
        }
        
        $index->commit();
        */
    }

}

