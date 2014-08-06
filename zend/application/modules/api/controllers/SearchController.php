<?php

class Api_SearchController extends Zend_Controller_Action
{

    public function init()
    {

        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('hits', 'json')
                      ->addActionContext('results', 'json')
                      ->initContext('json');

    }

    public function hitsAction()
    {

        $indexPath = Zend_Registry::get('config')->search->lucene_index_path;
        Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_TextNum_CaseInsensitive());
        
        $index = Zend_Search_Lucene::open($indexPath);
        Zend_Search_Lucene_Search_Query_Wildcard::setMinPrefixLength(0);
        $p_query = $this->_getParam('query');

        if (Genocad_Application::isLoggedIn()) {
            $user_id = (int)Genocad_Application::getUser()->user_id;
            $query = sprintf('(%s) and (user_id: %s or user_id: 0)', $p_query, $user_id); 
        } else {
            $user_id = -1;
            $query = sprintf('(%s) and (user_id: 0)', $p_query);
        }

        if (isset($p_query) && $p_query != "") {

            $results = $index->find($query);
            $this->view->hits = count($results);

        } else {

            $this->view->hits = 0;
        }

    }

public function resultsAction()
    {
		$blast = ($this->getRequest()->getParam('blast', 0) == 1);
		$dataTable = array();
        
		if ($blast) {
			
			$sequence = $this->getRequest()->getParam('sequence');
        	$queryFrom = $this->getRequest()->getParam('queryFrom');
        	$queryTo = $this->getRequest()->getParam('queryTo');
        	$searchType = $this->getRequest()->getParam('searchType');
        	$optimizeFor = $this->getRequest()->getParam('optimizeFor');
        	$dbParts = new Application_Model_DbTable_Parts();

			$blastTable = Genocad_Utilities_Parts_Blast::execBlastSearch($sequence, $queryFrom, $queryTo, $searchType, $optimizeFor);
			
			if (Genocad_Application::isLoggedIn()) {
            	$user_id = (int)Genocad_Application::getUser()->user_id;
        	} else {
            	$user_id = -1;
        	}
			
			foreach ($blastTable as $part) {
				if (($part[1] == $user_id) || ($part[1] == "0")) {
					$arrPart = array();
    				$partData = $dbParts->getPartbyPartID($part[0]);
                	if ($part[1] == $user_id) {
                   		$class = "part-edit";
                	} else {
                    	$class = "part-detail";
                	}
                
    				$arrPart[] = sprintf('<input name="part_id[]" type="checkbox" value="%s"/>', $partData->id);
            		$arrPart[] = sprintf('<a href="#" id="%s" class="%s">%s</a>', $partData->id , $class, $part[0]);
            		$arrPart[] = $partData->description;
            		$arrPart[] = (float)$part[2];
            		$arrPart[] = $partData->getSearchCategories();
            		$arrPart[] = (float)$part[3];
    				$arrPart[] = (float)$part[4];
    			
                	$dataTable[] = $arrPart;
				} 
			} 
		} else {    
			$indexPath = Zend_Registry::get('config')->search->lucene_index_path;
        	Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_TextNum_CaseInsensitive());
        
        	$index = Zend_Search_Lucene::open($indexPath);
        	Zend_Search_Lucene_Search_Query_Wildcard::setMinPrefixLength(0);
        	$p_query = $this->_getParam('query');

        	if (Genocad_Application::isLoggedIn()) {
            	$user_id = (int)Genocad_Application::getUser()->user_id;
            	$query = sprintf('(%s) and (user_id: %s or user_id: 0)', $p_query, $user_id); 
        	} else {
            	$user_id = -1;
            	$query = sprintf('(%s) and (user_id: 0)', $p_query);
        	}

        
        	if (isset($p_query) && $p_query != "") {

            	$results = $index->find($query);

            	foreach ($results as $part) {
                	$arrPart = array();
    
                	if ($part->user_id == $user_id) {
                    	$class = "part-edit";
                	} else {
                    	$class = "part-detail";
                	}
                
                  	$arrPart[] = sprintf('<input name="part_id[]" type="checkbox" value="%s"/>', $part->part_id_pk);
                	$arrPart[] = sprintf('<a href="#" id="%s" class="%s">%s</a>', $part->part_id_pk, $class, $part->part_id);
                	$arrPart[] = $part->part_name;
                	$arrPart[] = round($part->score * 100, 2);
                	$arrPart[] = $part->category;
                
                $dataTable[] = $arrPart;
            }
        }     
	}
    $this->view->aaData = $dataTable;

    }
    
}
