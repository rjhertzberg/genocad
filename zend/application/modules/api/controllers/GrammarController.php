<?php

class Api_GrammarController extends Zend_Controller_Action
{

    public function init()
    {
        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('grammar', 'json')
                      ->addActionContext('grammar-summary', 'json')
                      ->addActionContext('categories', 'json')
                      ->addActionContext('rules', 'json')
                      ->addActionContext('delete', 'json')
                      ->initContext('json');
    }

    public function grammarAction()
    {

        $arrGrammar = array();
        $parts_cnt = 0;
        $library_cnt = 0;

        $grammar_id = $this->_request->getParam('id');
        $dbGrammar = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammar->find($grammar_id)->current();
        $arrGrammar = $grammar->toArray();
        $arrGrammar["is_attribute_grammar"] = ($grammar->isAttributeGrammar() ? "Yes" : "No");
        $arrGrammar["isDeletable"] = ($grammar->isDeletable()? "true" : "false");

        $arrGrammar["libraries"] = array();

        $arrCategories = array();

        foreach($grammar->getCategories() as $category) {

            $arrCategory = $category->toArray();
            $arrCategory["image_url"] = $category->getImageUrl();
            $arrCategory["label"] = $category->getLabel();
            $genbank = $category->getGenbankQualifier();
            $arrCategory["genbank_label"] = isset($genbank) ? $genbank->qualifier : 'N/A';
            $arrCategory["isDeletable"] = ($category->isDeletable()? "true" : "false");

            $arrRules = array();

            foreach ($category->getRules() as $rule) {
                $arrRule = $rule->toArray();
                $arrRule["change_to"] = $rule->__toString();
                $arrRules[] = $arrRule;
            }

            $arrCategory["rules"] = $arrRules;

            $arrReferences = array();

            foreach ($category->getRuleTransform() as $rule) {
                $arrReferences[] = $rule->toArray();
            }

            $arrCategory["references"] = $arrReferences;

            $arrCategories[$category->category_id] = $arrCategory;

        }
        $arrGrammar["categories"] = $arrCategories;

        $arrRules = array();

        foreach ($grammar->getRules() as $rule) {
            $arrRule = $rule->toArray();
            $arrRule["change_to"] = $rule->code;
        
            foreach ($rule->getRuleTransform() as $transform) {
                $arrRule["transform"][] = $transform->toArray();
            }

            $arrRules[$rule->rule_id] = $arrRule;
        }

        $arrGrammar["rules"] = $arrRules;

        foreach ($grammar->getUserLibraries() as $library) {
            $arrGrammar["libraries"][] = $library->toArray();
            $parts_cnt += $library->getPartCount();
            $library_cnt ++;
        }
        
        // add some counts to the grammar node
        $arrGrammar["cnt_categories"] = count($arrCategories);
        $arrGrammar["cnt_libraries"] = $library_cnt;
        $arrGrammar["cnt_parts"] = $parts_cnt;
        $arrGrammar["cnt_rules"] = count($arrRules);
        $arrGrammar["icon_set_url"] = $grammar->getIconUrl();
        
        $this->view->grammar = $arrGrammar;
    }

    public function grammarSummaryAction()
    {

        $arrGrammar = array();
        $parts_cnt = 0;
        $category_cnt = 0;
        $library_cnt = 0;
        $designs_cnt = 0;
        $partsArray = Array();

        $grammar_id = $this->_request->getParam('id');
        $dbGrammar = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammar->find($grammar_id)->current();
        $arrGrammar = $grammar->toArray();
        $arrGrammar["is_attribute_grammar"] = ($grammar->isAttributeGrammar() ? "Yes" : "No");

        foreach ($grammar->getLibraries() as $library) {
            $library_cnt ++;
            $designs_cnt += count($library->getDesigns());
        }
        
        foreach ($grammar->getCategories() as $category) {
        	$category_cnt += 1;
        	foreach ($category->getParts() as $part) {
        		if (!(array_key_exists($part->id, $partsArray))) {
        			$partsArray[$part->id] = 1;
        		} else {
        			$partsArray[$part->id] += 1;
        		}
        	}	
        }

        $parts_cnt = count($partsArray);

        // add some counts to the grammar node
        $arrGrammar["cnt_categories"] = $category_cnt;
        $arrGrammar["cnt_libraries"] = $library_cnt;
        $arrGrammar["cnt_parts"] = $parts_cnt;
        $arrGrammar["cnt_rules"] = count($grammar->getRules());
        $arrGrammar["cnt_designs"] = $designs_cnt;
        $arrGrammar["icon_set_url"] = $grammar->getIconUrl();
        
        $this->view->grammar = $arrGrammar;
    }
    
    public function categoriesAction ()
    {
        $grammar_id = $this->_request->getParam('grammar');

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammars->find($grammar_id)->current();
        
        $categories = array();
        foreach ($grammar->getCategories() as $category) {
            $categories[$category->category_id] = $category->toArray();
            $categories[$category->category_id]["label"] = $category->getLabel();
        }

        $this->view->categories = $categories;

    } 

    public function rulesAction ()
    {
        $grammar_id = $this->_request->getParam('grammar');

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammars->find($grammar_id)->current();
        
        $rules = array();

        foreach ($grammar->getRules() as $rule) {

            $rules[$rule->rule_id] = $rule->toArray();
            foreach ($rule->getRuleTransform() as $transform) {
                $rules[$rule->rule_id]["transform"][] = $transform->toArray();
            }
        }

        $this->view->rules = $rules;

    }


    public function categoryTreeAction()
    {

        $grammar_id = $this->_request->getParam('id');
        $dbGrammar = new Application_Model_DbTable_Grammars();
        $dbRules = new Application_Model_DbTable_Rules();
        $grammar = $dbGrammar->find($grammar_id)->current();

        $tree = array();

        $arrRewritable = array();
        $arrRewritable["attr"]["id"] = 0;
        $arrRewritable["data"]["title"] = "Rewritable Categories";

        // adding these two attributes to the array will modify the jsTree component so that
        // this node is considered a "root" type and will prevent the node from being selected.
        $arrRewritable["attr"]["rel"] = "root";
        $arrRewritable["data"]["attr"]["style"] = "cursor: default; font-weight: bold";


        $arrTerminal = $arrRewritable;
        $arrTerminal["data"]["title"] = "Terminal Categories";
        
        $arrOrphaned = $arrTerminal;
        $arrOrphaned["data"]["title"] = "Orphaned Categories";

        $categories = $grammar->getCategories();

        foreach($categories as $key => $category) {
            $arrCategory = $category->getJsTreeNode($category->category_id);

            $arrRules = array();

            foreach ($category->getRules() as $rule) {
                $arrChild = array();
    
                $arrChild["attr"]["rel"] = "root";
                $arrChild["data"]["title"] = $rule->code . ' (' . $rule . ')';
                $arrChild["data"]["icon"] = new Zend_Json_Expr(sprintf('"/images/other/right-arrow.png"', $grammar_id, $category["icon_name"]));
                $arrRules[] = $arrChild;
                            
            }

            if (count($arrRules) > 0) {
                $arrChildRules = array();
                $arrChildRules["attr"]["rel"] = "root";
                $arrChildRules["data"]["title"] = "Child Rules";
                $arrChildRules["children"][] = $arrRules;
                
                $arrCategory["children"][] = $arrChildRules;  
            }

            $arrRules = array();

            foreach ($category->getRuleTransform() as $rule_id) {
                $rule = $dbRules->find($rule_id->rule_id)->current();
                $arrParent = array();
    
                $arrParent["attr"]["rel"] = "root";
                $arrParent["data"]["title"] = $rule->code . ' (' . $rule . ')';
                $arrParent["data"]["icon"] = new Zend_Json_Expr(sprintf('"/images/other/right-arrow.png"', $grammar_id, $category["icon_name"]));
                $arrRules[] = $arrParent;
                            
            }

            if (count($arrRules) > 0) {
                $arrParentRules = array();
                $arrParentRules["attr"]["rel"] = "root";
                $arrParentRules["data"]["title"] = "Parent Rules";
                $arrParentRules["children"][] = $arrRules;
                
                $arrCategory["children"][] = $arrParentRules;  
            }
            

            if ($category->isOrphaned()) {
                $arrOrphaned["children"][] = $arrCategory;
                $arrOrphaned["state"] = "open";
            } else if ($category->isRewritable()) {
                $arrRewritable["children"][] = $arrCategory;
                $arrRewritable["state"] = "open";
            } else {
                $arrTerminal["children"][] = $arrCategory;
                $arrTerminal["state"] = "open";
            }
        }

        $tree[0] = $arrRewritable;
        $tree[1] = $arrTerminal;
        $tree[2] = $arrOrphaned;

        $this->view->categories = $tree;
    }


    public function deleteAction()
    {

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammars->find($this->getRequest()->getParam('id'))->current();
        if ($grammar->isDeletable()) {
            $this->view->grammars = $dbGrammars->deleteGrammar($grammar->grammar_id);
            $this->view->message = $grammar->name . " has been deleted.";
            $this->view->success = 1;
        } else {
            $this->view->message = $grammar->name . " can not be deleted.";
            $this->view->success = 0;
        }

    }
    
}
