<?php

class Api_PartsController extends Zend_Controller_Action
{

    public function init()
    {
        $this->db = Zend_Db::factory(Zend_Registry::get('config')->resources->db);
        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('datatable', 'json')
                      ->initContext('json');
    }

    public function tree1Action()
    {

        $dbLibraries = new Application_Model_DbTable_Libraries();

        $public = $this->_request->getParam('public');
        $id = $this->_request->getParam('grammar_id');
        $orphaned = $this->_request->getParam('orphan');

        $tree = array();

        if ($orphaned == 1 && Genocad_Application::isLoggedIn()) {
            $tree[] = array("attr" => array("rel" => "recycle", "id"=> "recycle"), "data"=>array("title"=>"Orphaned Parts", "icon"=>new Zend_Json_Expr('"/images/recycle.png"')));
        } else {
            $libraryRows = $dbLibraries->getLibrariesByGrammar($id, true, true);
    
            foreach ($libraryRows as $libkey => $library) {
                $arrLibrary = $library->getJsTreeNode();
    
                // now get the categories within the library
                foreach ($library->getCategories() as $category) {
                    $arrLibrary["children"][] = $category->getJsTreeNode($library->library_id . '/' .$category->category_id);
                }
    
                $tree[] = $arrLibrary;
            }
        }

        $this->view->grammars = $tree;
    }

    public function grammarTreeAction()
    {

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $tree = array();
        
        $public = array();
        $public["state"] = "open";
        $public["attr"]["rel"] = "root";
        $public["data"]["title"] = "Public Grammars";
        $public["data"]["attr"]["style"] = "cursor: default; font-weight: bold";

        // get the public grammars
        foreach($dbGrammars->getPublicGrammars() as $grammar) {
            $nodeGrammar = $grammar->getJsTreeNode();
            $nodeGrammar["attr"]["rel"] = "";
            $nodeGrammar["data"]["attr"]["style"] = "";
            $nodeGrammar["state"] = "";

            $public["children"][] = $nodeGrammar;

        }
        
        $tree[] = $public;

        if (Genocad_Application::isLoggedIn()) {
            
            $private = array();
            $private["state"] = "open";
            $private["attr"]["rel"] = "root";
            $private["data"]["title"] = "User Grammars";
            $private["data"]["attr"]["style"] = "cursor: default; font-weight: bold";

            // get the public grammars
            foreach($dbGrammars->getUserGrammars() as $grammar) {
                $nodeGrammar = $grammar->getJsTreeNode();
                $nodeGrammar["attr"]["rel"] = "";
                $nodeGrammar["data"]["attr"]["style"] = "";
                $nodeGrammar["state"] = "";
    
                $private["children"][] = $nodeGrammar;
    
            }
    
            $tree[] = $private;

        }

        $this->view->tree = $tree;

    }
    
    public function libraryTreeAction()
    {
    
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $private = $this->_request->getParam('private', 0) == 1;

        $tree = array();

        // select only the grammar rows that have libraries associated with them
        $grammarRows = $dbGrammars->getLibraryGrammars();

        foreach($grammarRows as $key => $grammar) {

            $nodeGrammar = $grammar->getJsTreeNode();

            $libraryRows = $dbLibraries->getLibrariesByGrammar($grammar->grammar_id, !$private, true);
    
            foreach ($libraryRows as $libkey => $library) {
                $arrLibrary = $library->getJsTreeNode();
    
                // now get the categories within the library
                foreach ($library->getCategories() as $category) {
                    $arrLibrary["children"][] = $category->getJsTreeNode($library->library_id . '/' .$category->category_id);
                }
    
                $nodeGrammar["children"][] = $arrLibrary;
            }

            if (!isset($nodeGrammar["children"])) {
                $nodeGrammar["state"] = null;
            }
            $tree[] = $nodeGrammar;

        }

        if (Genocad_Application::isLoggedIn()) {
            $tree[] = array("attr" => array("rel" => "recycle", "id"=> "recycle"), "data"=>array("title"=>"Orphaned Parts", "icon"=>new Zend_Json_Expr('"/images/recycle.png"')));
        }

        $this->view->tree = $tree;

    }
    
    public function mypartstreeAction() {
    
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $dbCategories = new Application_Model_DbTable_Categories();

        $tree = array();

        // select only thre grammar rows
        $grammarRows = $dbGrammars->getMyPartsGrammars();

        foreach($grammarRows as $key => $grammar) {

            $nodeGrammar = $grammar->getJsTreeNode();
    
            // adding these two attributes to the array will modify the jsTree component so that
            // this node is considered a "root" type and will prevent the node from being selected.
            $nodeGrammar["attr"]["rel"] = "myparts";
            $nodeGrammar["data"]["attr"]["style"] = "cursor: default; font-weight: bold";

            // now get the categories within the library

            $sqlCategories = 'SELECT distinct c.* FROM v_parts_browser p, categories c where c.category_id = p.category_id and c.grammar_id = ' . $grammar->grammar_id . ' and p.part_user_id = ' . Genocad_Application::getUser()->user_id;
            $categoryRows = $this->db->fetchAll($sqlCategories);

            foreach ($categoryRows as $catkey => $category) {
                $cat = $dbCategories->find($category["category_id"])->current();

                $nodeGrammar["children"][] = $cat->getJsTreeNode($grammar->grammar_id . '/' .$cat->category_id);
            }

            $tree[$key] = $nodeGrammar;

        }

        $this->view->tree = $tree;
    }

    public function datatableAction()
    {

        if (Genocad_Application::isLoggedIn()) {
            $user_id = Genocad_Application::getUser()->user_id;;
            //$user_id = $user
        } else {
            $user_id = -1;
        }
        
        $dbCategories = new Application_Model_DbTable_Categories();
        $library = $this->_request->getParam('libid');
        $category = $this->_request->getParam('catid');
        $grammar = $this->_request->getParam('gid');
        $type = (int) $this->_request->getParam('type');
        $offset = $this->_request->getParam('iDisplayStart', 1);
        $count = $this->_request->getParam('iDisplayLength', 25);
        $filter = $this->_request->getParam('sSearch');
        $detail_url = "/parts/part/detail/id/";

        $columns = array('p.id', 'p.category_description', 'p.category_id', 'p.part_id', 'p.part_name', 'p.part_last_modified', 'p.part_description_text', 'p.grammar_id', 'p.part_user_id', 'p.icon_name', 'p.category_letter');
        $filter_cols = array('p.part_id', 'p.part_name');

        $select = $this->db->select();

        $select->from(array('p' => 'v_parts_browser'), $columns);

        if ($type == 2) {
            // My Parts
            $select->where('part_user_id = ?', $user_id);

            if (isset($grammar) && $grammar !== null) {
                $select->where('grammar_id = ?', (int) $grammar);
            }
            if (isset($category) && null !== $category) {
                $select->where('category_id = ?', (int) $category);
            }
        } else if ($type == -1) {
            // Orphaned Parts
            $select->where('part_user_id = ?', $user_id);
            $select->where('id not in (select part_id from library_part_join)');
        } else {

            if (isset($library) && $library !== null) {
    
                // join to the library_part_join table through the parts.id and don't select any columns
                $select->join(array('lpj' => 'library_part_join'), 'lpj.part_id = p.id', array())
                       ->where('lpj.library_id = ?', (int) $library);
                
    
                if (isset($category) && null !== $category) {
                    $select->where('category_id = ?', (int) $category);
                }
    
            } elseif (isset($grammar) && $grammar !== null) {
                $select->where('id in (select part_id from partslist_parts where partslist_id = ?)', Genocad_Application::getPartsList()->id);
                $select->where('part_user_id in (0, ?)', $user_id);
                $select->where('grammar_id = ?', (int) $grammar);
                 
                 if (isset($category) && null !== $category) {
                    $select->where('category_id = ?', (int) $category);
                }
    
            } else {
                $select->where('part_user_id = (-1 * ?)', $user_id);
                $select->where('id not in (select part_id from library_part_join)');
            }
        }
        
        // at this point, fetch all the records to get a total count
        $allRows = $this->db->fetchAll($select);
        $this->view->iTotalRecords = count($allRows);

        $filter_where = "";
        if (isset($filter) and $filter != "") {
            foreach ($filter_cols as $key=> $column) {
                $filter_where .= "(" . $column . " like '%" . $filter . "%')";
                if ($key < count($filter_cols) - 1) {
                    $filter_where .= " or ";
                }
            }
            $select->where($filter_where);
        }

        // at this point, fetch all the records to get a total count
        $filteredRows = $this->db->fetchAll($select);
        $this->view->iTotalDisplayRecords = count($filteredRows);
        
        $select->order('p.category_description asc');

        $sort_col = $this->_request->getParam('iSortCol_0');
        $sorting_cols = $this->_request->getParam('iSortingCols');
        
        if ( isset( $sort_col ) ) {

            for ( $i = 0 ; $i < $sorting_cols ; $i++ )
            {
                $sort_col = $this->_request->getParam('iSortCol_'.$i);
                $sort_dir = $this->_request->getParam('sSortDir_'.$i);

                $col = $columns[$sort_col];

                $select->order($col . " " . $sort_dir);
            }
        }

        if (isset($offset) && $count <> -1) {
            $select->limit($count, $offset);
        }


        $partsRows = $this->db->fetchAll($select);
        $dataTable = array();

        foreach ($partsRows as $part) {
            $cat = $dbCategories->find($part["category_id"])->current();
            $arrPart = array();
            
            if ($part["part_user_id"] == $user_id) {
                $class = "part-edit";
            } else {
                $class = "part-detail";
            }
            
            $arrPart[] = sprintf('<input name="part_id[]" type="checkbox" value="%s"/>', $part["id"]);
            $arrPart[] = sprintf('<img align="absmiddle" width="24" src="%s"/> %s', $cat->getImageUrl(), $cat->getLabel());
            $arrPart[] = sprintf('<a href="#" id="%s" class="%s">%s</a>', $part["id"], $class, $part["part_id"]);
            $arrPart[] = $part["part_name"];
            $arrPart[] = $part["part_last_modified"];
            $arrPart[] = $part["part_description_text"];
            if ($part["part_description_text"] != "") {
                $arrPart[] = sprintf('<span class="ui-icon ui-icon-comment" title="%s"></span>', $part["part_description_text"]);
            } else {
                $arrPart[] = "";
            }

            $dataTable[] = $arrPart;
        }
        
        $this->view->sEcho = $this->_request->getParam('sEcho');
        $this->view->aaData = $dataTable;
        
    }

}
