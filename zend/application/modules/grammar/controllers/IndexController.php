<?php

class Grammar_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        $this->view->headTitle("GenoCAD: Grammar Editor");
        $this->view->headScript()->appendFile('/js/dataTables-1.7/media/js/jquery.dataTables.js');
        $this->view->headScript()->appendFile('/js/dataTables.fnReloadAjax.js');
        $this->view->headScript()->appendFile('/js/grammar-editor.js');
        $this->view->headScript()->appendFile('/js/tiptip/jquery.tipTip.js');
        $this->view->headScript()->appendFile('/js/jquery.multiselect2side.js');
        $this->view->headScript()->appendFile('/js/multiselect/jquery.multiselect.min.js');

        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_page.css');
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_table_jui.css');
        $this->view->headLink()->appendStylesheet('/js/tiptip/tipTip.css');
        $this->view->headLink()->appendStylesheet('/js/jquery.multiselect2side.css');
        $this->view->headLink()->appendStylesheet('/js/multiselect/jquery.multiselect.css');
        
        
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('success', 'json')
                      ->addActionContext('edit-rule', 'json')
                      ->initContext('json');

    }

    public function indexAction()
    {

        $this->view->headScript()->appendFile('/js/grammar_test.js');
        $this->view->headScript()->appendFile('/js/json2.js');
        $this->view->headScript()->appendFile('/js/jstree/jquery.jstree.js');
        $this->view->headScript()->appendFile('/js/msdropdown/js/jquery.dd.js');
        $this->view->headScript()->appendFile('/js/selectmenu/jquery.ui.selectmenu.js');

        $this->view->headLink()->appendStylesheet('/css/grammar.css');
        $this->view->headLink()->appendStylesheet('/js/msdropdown/dd.css');
        $this->view->headLink()->appendStylesheet('/js/selectmenu/jquery.ui.selectmenu.css');
        //$this->view->headLink()->appendStylesheet('/css/redmond/jquery-ui-1.8.4.custom.css');

        $grammar_id = $this->_request->getParam('id', 0);
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammars->find($grammar_id)->current();

        // if the user attempted to access a grammar that doesn't exist, or one that 
        // they don't have access to, redirect them back to the parts browser
        if (!isset($grammar) || !$grammar->isAccessible()) {
            $this->_helper->getHelper('Redirector')->gotoSimple('index', 'index', 'parts');
            return;
        }

        $this->view->grammar = $grammar;
        $this->view->grammars = $dbGrammars->getGrammarList();

    }

    public function newAction()
    {

        // The user needs to be logged in to access this action
        if (!Genocad_Application::isLoggedIn()) {
            $this->_helper->getHelper('Redirector')->gotoSimple('index', 'login', '', array('refurl' => urlencode('/grammar/index/new')));
            return;
        }

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $frmGrammar = new Grammar_Form_Grammar();
        $frmGrammar->removeElement('starting_category_id');
        $frmGrammar->removeElement('include_libraries');
        $this->view->grammar_id = $this->_request->getParam('id', 0);

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
            if ($frmGrammar->isValid($data)) {
                $row = $dbGrammars->saveGrammarForm($frmGrammar);
                $this->_helper->getHelper('Redirector')->gotoSimple('index', 'index', 'grammar', array('id'=>$row->grammar_id));
            } else {
                $frmGrammar->populate($data);
            }

        }

        $this->view->form = $frmGrammar;
        $frmImport = new Grammar_Form_Import();
        $frmImport->setAttrib("action", '/grammar/index/import/');
        $this->view->form_import = $frmImport;

    }

    public function editGrammarAction()
    {

        $this->_helper->layout()->disableLayout();
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $frmGrammar = new Grammar_Form_Grammar();
        $frmGrammar->removeElement('submit');
        $frmGrammar->removeElement('include_libraries');
        $grammar_id = $this->_request->getParam('id');
        $grammar = $dbGrammars->find($grammar_id)->current();
        $categories = $grammar->getCategoryList();
        
        if ($categories) {
            $frmGrammar->getElement('starting_category_id')->addMultiOptions($grammar->getCategoryList());
        }
        
        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
            if ($frmGrammar->isValid($data)) {
            	$code_init = $this->_request->getParam('code_init');
            	$code_end = $this->_request->getParam('code_end');
            	$code_tbgenerated = $this->_request->getParam('code_tbgenerated');
                $row = $dbGrammars->saveGrammarForm($frmGrammar, $code_init, $code_end, $code_tbgenerated);
                $response = $row->toArray();
                $response["starting_category"] = $row->getStartingCategory()->getLabel();
                $this->_forward("success","index", "grammar", array(
                    "message" => "The Grammar has been updated.", 
                    "data" => $response
                ));
                return;
            } else {
                $frmGrammar->populate($data);
                $frmGrammar->getElement('is_attribute')->setValue($grammar->isAttributeGrammar());
            }

        } else {
            $frmGrammar->populate($grammar->toArray());
            $frmGrammar->is_attribute->setValue($grammar->isAttributeGrammar());
        }
        
        $this->view->form = $frmGrammar;
    	if ($grammar->isAttributeGrammar()) {
            $attributeGrammar = $grammar->getAttributeGrammars();
            $codeTbgenerated = $grammar->getCodeTbgenerated();
            $this->view->attributeGrammar = $attributeGrammar;
            $this->view->codeTbgenerated = $codeTbgenerated;
            $this->view->grammar_id = $grammar_id;
    		$this->render('detail-attribute' );
        }
    }
    
	public function addCodeAction()
    {

        $this->_helper->layout()->disableLayout();
        $dbCode = new Application_Model_DbTable_CodeTbgenerated();
        $frmCode = new Grammar_Form_Code();
        $grammar_id = $this->_request->getParam('grammar_id');
        
        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
            if ($frmCode->isValid($data)) {
            	$grammar_id = $this->_request->getParam('grammar_id');
            	$type = $this->_request->getParam('type');
            	$code = $this->_request->getParam('code');
            	
            	$dbCode->add($grammar_id, $type, $code);
            	return;
            } else {
                $frmCode->populate($data);
            }

        } else {
            $frmCode->populate(array("grammar_id" => $grammar_id));
        }
        
        $this->view->form = $frmCode;
   	}
    
    public function convertGrammarAction() {
    	$this->_helper->layout()->disableLayout();
    	
    	$dbGrammars = new Application_Model_DbTable_Grammars();
    	$grammar_id = $this->_request->getParam('id');
    	
    	$grammar = $dbGrammars->find($grammar_id)->current();
    	
    	$grammar->convert();
    }

    public function editCategoryAction()
    {

        $this->_helper->layout()->disableLayout();

        $dbCategories = new Application_Model_DbTable_Categories();
        $dbGrammars = new Application_Model_DbTable_Grammars();
            
        $grammar_id = $this->_request->getParam('grammar_id');
        $id = $this->_request->getParam('id');

        $frmCategory = new Grammar_Form_Category();
        $frmCategory->letter->addValidator(new Genocad_Validate_UniqueCategoryLetter(new Application_Model_DbTable_Categories()));

        if ($grammar_id == "") {
            $category = $dbCategories->find($id)->current();
            $grammar = $category->getGrammar();
            $frmCategory->populate($category->toArray());
        } else {
            $grammar = $dbGrammars->find($grammar_id)->current();
            $frmCategory->grammar_id->setValue($grammar_id);
        }
        

        
        foreach (Application_Model_ImageSets::getImageSetImages($grammar->icon_set) as $image) {
            $frmCategory->getElement('icon_name')->addMultiOption($image['name'], $image['name']);
        }

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
            if ($frmCategory->isValid($data)) {
                $row = $dbCategories->saveCategoryForm($frmCategory);
                $this->_forward("success","index", "grammar", array("message"=>"The Category has been updated.", "data"=>$row->toArray()));
                return;
            } else {
                $frmCategory->populate($data);
            }

        }

        $this->view->form = $frmCategory;
        
    }
    
	public function editAttributesAction()
    {

        $this->_helper->layout()->disableLayout();

        $dbCategories = new Application_Model_DbTable_Categories();
        
        $id = $this->_request->getParam('id');

        $frmCategoryAttribute = new Grammar_Form_Attributes();
        
        $category = $dbCategories->find($id)->current();
        $frmCategoryAttribute->populate($category->toArray());
        
        // populate the attributes listing
        $tmpAttributes = $category->getAttributes();
        $count = 0;
        
    	foreach ($tmpAttributes as $tmpAttribute) {
            $frmCategoryAttribute->getElement('category_attributes')->addMultiOption($tmpAttribute->id, $tmpAttribute->name);
            $count++;
        }
        
        if ($count == 0) {
        	$frmCategoryAttribute->getElement('category_attributes')->addMultiOption(-1, 'No attributes available');
        }
                
        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
            if ($frmCategoryAttribute->isValid($data)) {
                return;
            } else {
                $frmCategoryAttribute->populate($data);
            }

        }

        $this->view->form = $frmCategoryAttribute;
        
    }
    
    
	public function editAttributeAction()
    {

        $this->_helper->layout()->disableLayout();

        $dbAttributes = new Application_Model_DbTable_CategoryAttributes();
        $dbCategories = new Application_Model_DbTable_Categories();
        $dbGrammars = new Application_Model_DbTable_Grammars();
        
        $category_id = $this->_request->getParam('category_id');
        $id = $this->_request->getParam('id');

        $frmAttribute = new Grammar_Form_Attribute();
        
              
        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
        	if ($frmAttribute->isValid($data)) {
        		
        		$attribute_id = $frmAttribute->getValue('id');
        		        		
        		if ($attribute_id == "") {
        			$row = $dbAttributes->add(
        						$frmAttribute->getValue('category_id'),
        						$frmAttribute->getValue('name'),
        						$frmAttribute->getValue('description', ""),
        						$frmAttribute->getValue('display_order', 0),
        						$frmAttribute->getValue('attribute_type'),
        						$frmAttribute->getValue('selected_categories')        						
        				);
        			$row->save();
        			$attribute_id = $row->id;	
        		} else {
        			$row = $dbAttributes->find($attribute_id)->current();
        			$row->edit(
        				$frmAttribute->getValue('category_id'),
        						$frmAttribute->getValue('name'),
        						$frmAttribute->getValue('description', ""),
        						$frmAttribute->getValue('display_order', 0),
        						$frmAttribute->getValue('selected_categories')        						
        				);
        			$row->save();
        		}
        		
                $this->_forward("success", "index", "grammar", array("message"=>"The Attribute has been updated.", "data"=>$row->toArray()));
                return;
            } else {
                $frmAttribute->populate($data);
            }
        } else {
        	if ($category_id != "") {
        	// Adding attribute
        		$category = $dbCategories->find($category_id)->current();
        		$frmAttribute->populate(array("category_id" => $category_id));	
        		$grammar_id = $category->grammar_id;
        		// populate the attributes listing
        		$grammar = $dbGrammars->find($grammar_id)->current();
        		$categories = $grammar->getCategories();
                
    			$frmAttribute->getElement('selected_categories')->addMultiOptions($grammar->getCategoryList());
            
        	} else {
        		// Editing attribute
        		$attribute = $dbAttributes->find($id)->current();
        		$frmAttribute->populate($attribute->toArray());
        		$category_id = $attribute->category_id;
        		$category = $dbCategories->find($category_id)->current();
        		$grammar_id = $category->grammar_id;
        		// populate the attributes listing
        		$grammar = $dbGrammars->find($grammar_id)->current();
        		$categories = $grammar->getCategories();
      			$frmAttribute->getElement('attribute_type')->setValue($attribute->attribute_type_id);
      			$frmAttribute->getElement('attribute_type')->setAttrib('disabled', true);
                
    			$frmAttribute->getElement('selected_categories')->addMultiOptions($grammar->getCategoryList())
    								->setValue($attribute->getListAssignsCategoryList());
            
        	}
        	
        }

        $this->view->form = $frmAttribute;
        
    }
    
    public function editRuleAction()
    {
        $this->_helper->layout()->disableLayout();

        if ($this->getRequest()->isPost()) {
        
            $id = $this->_request->getParam('rule_id', 0);
            $grammar_id = $this->_request->getParam('grammar_id');
            $code = $this->_request->getParam('code');
            $category_id = $this->_request->getParam('category_id');
            $transform = explode(',', $this->_request->getParam('transform'));
    
            
            $dbRules = new Application_Model_DbTable_Rules();
    
            if ($id == 0) {
                $row = $dbRules->add($code, $category_id, $grammar_id, $transform);
            }
            else {
                $row = $dbRules->find($id)->current();
                $row = $row->edit($id, $code, $category_id, $grammar_id, $transform);
            }

            $this->view->message = "The rule has been saved successfully.";
            $this->view->data = $row->toArray();

        } 

    }
    
	public function editSemanticAction()
    {
        $this->_helper->layout()->disableLayout();
        $dbSemantic = new Application_Model_DbTable_RuleSemanticActions();
        $dbRules = new Application_Model_DbTable_Rules();
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $frmSemantic = new Grammar_Form_Semantic();
        $frmSemantic->removeElement('submit');
        $rule_id = $this->_request->getParam('rule_id');
        $semantics = $dbSemantic->getByRule($rule_id);
        $action = "";
        $id = 0;

        if ($this->getRequest()->isPost()) {
        
            $id = $this->_request->getParam('semantic_id', 0);
            $action = $this->_request->getParam('action_code');

            $action = Genocad_Utilities_Designs_Compiler::convertSemanticAction ($rule_id, $action, true);
            
            if ($id == 0) {
            	// add
                $semantic = $dbSemantic->add($rule_id, $action);
            } else {
            	$semantic = $dbSemantic->find($id)->current();
                $row = $semantic->edit($rule_id, $action);
            }

            $this->view->message = "The rule semantic action has been saved successfully.";
            $this->view->data = $semantic->toArray();

        } else {
        	foreach ($semantics as $semantic) {
        		// There should be only one, but it will be saved as 1.
        		$action .= $semantic->action;
        		$id = $semantic->id;
        	} 
        	
        	// convert action to the displayable format
        	$action = Genocad_Utilities_Designs_Compiler::convertSemanticAction ($rule_id, $action, false);
        	$frmSemantic->populate(array("rule_id" => $rule_id, "semantic_id" => $id, "action_code" => $action));
        	
        	// get categories and attributes
        	$rule = $dbRules->find($rule_id)->current();
        	$grammar = $dbGrammars->find($rule->grammar_id)->current();
        	//$categories = $grammar->getCategoryList();
        	//$categories = $rule->getRuleCategories();
        	$attributes = $rule->getRuleCategoryAttributes();
        	//$frmSemantic->getElement('category_id')->addMultiOptions($categories);
        	$frmSemantic->getElement('attribute_id')->addMultiOptions($attributes);      	
        	
        }

        $this->view->form = $frmSemantic;
    }

    public function copyAction()
    {

        $grammar_id = $this->_request->getParam('id');

        // The user needs to be logged in to access this action
        if (!Genocad_Application::isLoggedIn()) {
            $this->_helper->getHelper('Redirector')->gotoSimple('index', 'login', '', array('refurl' => urlencode('/grammar/index/copy/id/' . $grammar_id)));
            return;
        }

        $dbGrammars = new Application_Model_DbTable_Grammars();
        
        $frmGrammar = new Grammar_Form_Grammar();
        $grammar = $dbGrammars->find($grammar_id)->current();

        $categories = $grammar->getCategoryList();
        
        $libraries = $grammar->getUsersLibraryList();

        if ($categories) {
            $frmGrammar->getElement('starting_category_id')->addMultiOptions($grammar->getCategoryList());
        }
        
        if ($libraries) {
        	$frmGrammar->getElement('include_libraries')->addMultiOptions($libraries);
        	$libValues = array();
        	foreach($libraries as $library) {
        		$libValues[] = $library["key"];
        	}
        	$frmGrammar->getElement('include_libraries')->setValue($libValues);
        } else {
        	$frmGrammar->removeElement('include_libraries');
        }

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
            if ($frmGrammar->isValid($data)) {
                $row = $dbGrammars->copyGrammar((int)$data["grammar_id"], $data);
                $this->_helper->getHelper('Redirector')->gotoSimple('index', 'index', 'grammar', array('id' => $row->grammar_id));
                return;
            } else {
                $frmGrammar->populate($data);
            }

        } else {

            // The user has not submitted the form, populate the form as appropriate
            $frmGrammar->populate($grammar->toArray());
            $frmGrammar->getElement('name')->setValue('Copy of ' . $grammar->name);
            
        }

        $this->view->form = $frmGrammar;
        $this->view->grammar = $grammar;

    }

    public function importAction()
    {

        $this->view->headLink()->appendStylesheet('/css/grammar.css');

        // The user needs to be logged in to access this action
        if (!Genocad_Application::isLoggedIn()) {
            $this->_helper->getHelper('Redirector')->gotoSimple('index', 'login', '', array('refurl' => urlencode('/grammar/index/import')));
            return;
        }

        $frmImport = new Grammar_Form_Import();
        $posted = $this->getRequest()->isPost();
        $process_step = (int) $this->getRequest()->getParam("step", 1);
    
        // check to see if this is a post request, meaning the user submitted the form
        if ($posted) {

            $data = $this->getRequest()->getParams();

            switch ($process_step) {

                case 1:

                    // validate the form, save the uploaded file and process the import
                    if ($frmImport->isValid($data)) {

                        $frmImport->file_name->receive();
                        
                        $file = new Genocad_Utilities_Grammar_ImportFile($frmImport->file_name->getFileName());
                        if ($file->validate()) {
                            $process_step = 2;
                            $this->view->grammar = $file->getGrammarXML();
                            $this->view->icon_set_exists = $file->iconSetExists();
                            //$this->view->form2 = new Grammar_Form_Import2();
                        } else {
                            $this->view->errors = $file->getErrors();
                        }

                    }

                    break;

                case 2:

                    $file = new Genocad_Utilities_Grammar_ImportFile();
                    $this->view->grammar = $file->getGrammarXML();
                    $this->view->icon_set_exists = $file->iconSetExists();
                    
                    $icon_choice = (int) $this->getRequest()->getParam("icon_choice", 0);
                    $iconset_name = $this->view->grammar->icon_set;

                    $valid = true;

                    // if the icon set already exists, then need to validate that the 
                    // user entered a choice for how to deal with it 
                    //if (Application_Model_ImageSets::exists((string) $this->view->grammar->icon_set)) {

                    //    $form = new Grammar_Form_Import2();
                    //    if ($icon_choice == 1) {
                    //        $form->new_icon_set->setRequired(false);
                    //    }
                    //    $data = $this->getRequest()->getParams();
                    //    $valid = $form->isValid($data);
                    //    $form->populate($data);
                    //    $this->view->form2 = $form;
                    //    $iconset_name = $data["new_icon_set"];
                    
                    //}

                    if ($valid) {
                        $grammar = $file->process($icon_choice, $iconset_name);
                        $this->_helper->getHelper('Redirector')->gotoSimple('index', 'index', 'grammar', array('id' => $grammar->grammar_id));
                        return;
                    }

                    break;

            }

        }
            
        $this->view->form = $frmImport;
        $this->view->process_step = $process_step;

    }

    public function exportAction()
    {

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $frmGrammar = new Grammar_Form_Grammar();
        $grammar = $dbGrammars->find($this->_request->getParam('id'))->current();
        
        if (!$grammar->isAccessible()) {
            $this->_redirect("/parts");
        }
        
    	$categories = $grammar->getCategoryList();
        
        $libraries = $grammar->getUsersLibraryList();

        if ($categories) {
            $frmGrammar->getElement('starting_category_id')->addMultiOptions($grammar->getCategoryList());
        }
        
        if ($libraries) {
        	$frmGrammar->getElement('include_libraries')->addMultiOptions($libraries);
        	$libValues = array();
        	foreach($libraries as $library) {
        		$libValues[] = $library["key"];
        	}
        	$frmGrammar->getElement('include_libraries')->setValue($libValues);
        } else {
        	$frmGrammar->removeElement('include_libraries');
        }
        
        //$this->_helper->layout()->disableLayout();
        $frmGrammar->getElement('name')->setAttrib('disabled', true);
        $frmGrammar->getElement('description')->setAttrib('disabled', true);
        $frmGrammar->getElement('starting_category_id')->setAttrib('disabled', true);
        $frmGrammar->removeElement('icon_set');
        $frmGrammar->getElement('submit')->setLabel('Export');

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getParams();

            // check to see if the posted data passes the form validation
            $zip = new ZipArchive();
        	$name = "grammar_" . $grammar->grammar_id . ".genocad";
        	$filename = sys_get_temp_dir() . "/" .$name;

        	if ($zip->open($filename, ZIPARCHIVE::CREATE)!==TRUE) {
            	exit("cannot open <$filename>\n");
        	}

        	$zip->addFromString('grammar.xml', $grammar->export($data));
       		foreach (Application_Model_ImageSets::getImageSetImages($grammar->icon_set) as $image) {
           		$zip->addFile($image["path"], 'icon_set/' . $grammar->icon_set . '/' . Application_Model_ImageSets::getImageSubfolder() . '/' . $image["name"]);
           		$zip->addFile(Application_Model_ImageSets::getImageSetIconPath($grammar->icon_set) . $image["name"], 'icon_set/' . $grammar->icon_set . '/' . Application_Model_ImageSets::getIconSubfolder() . '/' . $image["name"]);
       		}

       		$zip->close();
       		$file = file_get_contents($filename);

       		$this->getResponse()
           		->setBody($file)
           		->setHeader('Content-Type', 'application/zip')
           		->setHeader('Content-Disposition', 'attachment; filename="' . $name . '"')
           		->setHeader('Content-Length', strlen($file));

       		//disable the layout & view renderer
       		$this->_helper->layout->disableLayout();
       		$this->_helper->viewRenderer->setNoRender(true);

       		// delete the file
       		unlink($filename);
       		$frmGrammar->removeElement('icon_set');
            //$this->_helper->getHelper('Redirector')->gotoSimple('index', 'index', 'grammar', array('id' => $grammar->grammar_id));
           	return;

        } else {

            // The user has not submitted the form, populate the form as appropriate
            $frmGrammar->populate($grammar->toArray());
            $frmGrammar->getElement('name')->setValue($grammar->name);
            
        }

        $this->view->form = $frmGrammar;
        $this->view->grammar = $grammar;

    }

    public function imagesAction()
    {

        $this->_helper->layout()->disableLayout();
        $this->view->path = $this->_request->getParam('path');

    }

    public function successAction()
    {
        $this->view->message = $this->_request->getParam('message');
        $this->view->data = $this->_request->getParam('data');
    }

}
