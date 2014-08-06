<?php

class Api_PartslistController extends Zend_Controller_Action
{

    public function init()
    {
        $this->db = Zend_Db::factory(Zend_Registry::get('config')->resources->db);
        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('datatable', 'json')
                      ->addActionContext('count', 'json')
                      ->initContext('json');
    }

    public function countAction()
    {
        $dbPartsList = new Application_Model_DbTable_PartsList();
        $this->view->count = count($dbPartsList->getParts(Genocad_Application::getPartsList()->id));
    }

    public function treeAction()
    {

        $dbPartsList = new Application_Model_DbTable_PartsList();
        $cartNamespace = new Zend_Session_Namespace('PartsList');

        $tree = array();

        foreach($dbPartsList->getGrammars($cartNamespace->id) as $grammar) {

            $arrGrammar = $grammar->getJsTreeNode();
            $arrGrammar["attr"]["rel"] = "partslist";
            $arrGrammar["data"]["attr"]["style"] = "cursor: default; font-weight: bold";

            foreach ($dbPartsList->getCategories($cartNamespace->id, $grammar->grammar_id) as $category) {
                $arrCategory = $category->getJsTreeNode($grammar->grammar_id . '/' . $category->category_id);
                $arrCategory["attr"]["rel"] = "partslist";
                $arrGrammar["children"][] = $arrCategory;
            }

            $tree[] = $arrGrammar;

        }

        $this->view->tree = $tree;
    }

}





