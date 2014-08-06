<?php

class Parts_PartController extends Zend_Controller_Action
{

	public function init()
    {
        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('success', 'json')
                      ->initContext('json');
    }

    public function indexAction()
    {

        // instantiate the Library Form
        $form = new Parts_Form_Part();

        $this->view->form = $form;
    }

    public function detailAction()
    {

        // instantiate the Library Form
        $form = new Parts_Form_Part();

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $form->grammar_id->addMultiOptions($dbGrammars->getGrammarList());
    
        // instantiate the Parts model and get the requested library record
        $dbParts = new Application_Model_DbTable_Parts();
        $part = $dbParts->getPart($this->getRequest()->getParam('id'));

        $form->populate($part->toArray());

        // determine the grammar
        $grammar = $part->getGrammar();
        $categories = $part->getCategoryList();
        $form->category_id->addMultiOptions($categories);
        $user_id = ((Genocad_Application::isLoggedIn() ? (int)Genocad_Application::getUser()->user_id : 0));
        //$form->library_id->addMultiOptions($grammar->getUserandPublicLibraryList($user_id));
        $form->library_id->addMultiOptions($part->getUserandPublicLibraryList($part->user_id));

        $form->grammar_id->setValue($grammar->grammar_id);
        $form->grammar_id->setAttrib('disabled', true);
        $form->library_id->setLabel('Library:');
        $form->orig_grammar_id->setValue($form->grammar_id->getValue());

        foreach ($form->getElements() as $element) {
            $element->setRequired(false);
        }

        $this->view->form = $form;
        $this->view->categories = $part->getCategories();
        $this->view->grammar = $grammar;
        $this->view->part = $part;
        
        if ($grammar->isAttributeGrammar()) {
            $this->render('detail-attribute' );
        }

    }

    public function addAction()
    {

        // instantiate the Library Form
        $form = new Parts_Form_Part();
        $form->removeElement('part_id');

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $form->grammar_id->addMultiOptions($dbGrammars->getGrammarList());
                
        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();
            $data["category_id"] = $this->getRequest()->getParam('category_idms2side__dx'); //$data["category_idms2side__dx"];
            $form->category_id->setValue($data["category_id"]);

            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                // save the Parts record
                $part = new Application_Model_DbTable_Parts();

                $part->add (
                    $form->getValue('description'),
                    $form->getValue('segment'),
                    $form->getValue('description_text'),
                    $form->getValue('library_id'),
                    $form->getValue('category_id')
                );

                $this->_helper->redirector('success', 'part', 'parts', array("message" => "The Part was successfully saved"));

            } else {
                // the form isn't valid, but still need to populate the options based on chosen grammar
                $grammar_id = $data["grammar_id"];
                if ($grammar_id != '') {
                     $dbGrammars = new Application_Model_DbTable_Grammars();
                     $grammar = $dbGrammars->find($grammar_id)->current();

                     $form->category_id->addMultiOptions($grammar->getCategoryList())
                                       ->setValue($data["category_id"]);        
                     $form->library_id->addMultiOptions($grammar->getUserLibraryList((int)Genocad_Application::getUser()->user_id))
                                      ->setValue($this->getRequest()->getParam('library_id'));
                }
            }

        } else {

            // the user hasn't submitted the form
            // check to see if the library_id parameter was passed
            $library_id = $this->getRequest()->getParam('library_id', '-1'); 
            
            if ($library_id != '-1') {

                $dbLibraries = new Application_Model_DbTable_Libraries();

                $library = $dbLibraries->getLibrary($library_id);
                $grammar = $dbGrammars->find($library->grammar_id)->current();

                $form->grammar_id->setValue($grammar->grammar_id);
                $form->design_count->setValue(0);

                $form->category_id->addMultiOptions($grammar->getCategoryList());   
     
                $form->library_id->addMultiOptions($grammar->getUserLibraryList((int)Genocad_Application::getUser()->user_id))
                                 ->setValue($library_id);

            }
        }

        $this->view->form = $form;
    }

    public function editAction()
    {

        // instantiate the Library Form
        $form = new Parts_Form_Part();

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $form->grammar_id->addMultiOptions($dbGrammars->getGrammarList());

        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();
            $data["grammar_id"] = $data["orig_grammar_id"];


            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                // save the library record
                $dbParts = new Application_Model_DbTable_Parts();
                $part = $dbParts->getPart($form->getValue('id'));

                $part->edit (
                    $form->getValue('id'),
                    $part->part_id,
                    $form->getValue('description'),
                    $form->getValue('segment'),
                    $form->getValue('description_text'),
                    $form->getValue('library_id'),
                    $form->getValue('category_id')
                );

                $this->_helper->redirector('success', 'part', 'parts', array("message" => "The Part was successfully saved"));

           } else {

                // the form isn't valid, but still need to populate the options based on chosen grammar
                $dbParts = new Application_Model_DbTable_Parts();
                $part = $dbParts->getPart($form->getValue('id'));

                $grammar_id = $data["grammar_id"];
                if ($grammar_id != '') {

                     $grammar = $dbGrammars->find($grammar_id)->current();

                     $form->category_id->addMultiOptions($grammar->getCategoryList())
                                       ->setValue($this->getRequest()->getParam('category_id'));        
                     $form->library_id->addMultiOptions($grammar->getUserLibraryList((int)Genocad_Application::getUser()->user_id))
                                      ->setValue($this->getRequest()->getParam('library_id'));
                     $form->design_count->setValue($part->getDesignCount());
                     $form->part_id->setValue($part->part_id);                              
                }
            }

        } else {
        
            // instantiate the Parts model and get the requested library record
            $dbParts = new Application_Model_DbTable_Parts();
            $part = $dbParts->getPart($this->getRequest()->getParam('id'));
            $form->populate($part->toArray());
    
            // determine the grammar
            $grammar = $part->getGrammar();
            $form->category_id->addMultiOptions($grammar->getCategoryList())
                              ->setValue($part->getCategoryIds());        
            $form->library_id->addMultiOptions($grammar->getUserLibraryList($part->user_id));
            $form->library_id->setValue($part->getUserLibraryIds($part->user_id));
    
    
            // check to see if the library is editable
            if (!$part->isEditable()) {
                $form->addError('You do not have permission to edit this Part');
            }
    
            $form->grammar_id->setValue($grammar->grammar_id);
            $form->grammar_id->setAttrib('disabled', true);
            $form->grammar_id->setRequired(false);
            $form->orig_grammar_id->setValue($form->grammar_id->getValue());
            $form->design_count->setValue($part->getDesignCount());

        }
        
        $this->view->form = $form;
    }

    public function editAttributeAction() {
        
        // instantiate the Parts model and get the requested library record
        $dbParts = new Application_Model_DbTable_Parts();
        $part = $dbParts->getPart($this->getRequest()->getParam('id'));

        if ($this->getRequest()->isPost()) {
        
            $data = $this->getRequest()->getPost();
            $part_id = $data["part_id"];
            $dbPartAttributes = new Application_Model_DbTable_PartsCategoryAttributes();
            
            $dbPartAttributes->clearForSave($part_id);

            foreach ($data["attribute"] as $key => $attributes) {
                $dbPartAttributes->set($part_id, $key, $attributes);
            }
            $this->_helper->redirector('success', 'part', 'parts', array("message" => "The Part was successfully saved"));
            
        } else {
            // determine the grammar
            $grammar = $part->getGrammar();
            $categories = $part->getCategoryList();
            $user_id = ((Genocad_Application::isLoggedIn() ? (int)Genocad_Application::getUser()->user_id : 0));
            $this->view->categories = $part->getCategories();
            $this->view->grammar = $grammar;
            $this->view->part = $part;
        }
        
    }

	public function editMappedAction() {
        
		$form = new Parts_Form_MapAttribute();
        // instantiate the Parts model and get the requested library record
        $dbParts = new Application_Model_DbTable_Parts();
        $dbCategoryAttribute = new Application_Model_DbTable_CategoryAttributes();
        $dbPartsCategoryAttribute = new Application_Model_DbTable_PartsCategoryAttributes();
        $part_attribute_id = $this->getRequest()->getParam('id');
        $part_id = $this->getRequest()->getParam('part_id');
        $attribute_id = $this->getRequest()->getParam('attribute_id');
        
        if ($this->getRequest()->isPost()) {
        	$data = $this->getRequest()->getPost();
        	//$new_value = "[".$form->getValue('map_part_id').",".$form->getValue('map_value')."]";
        	$new_value = "[".$data["map_part_id"].",".$data["map_value"]."]";	
        	if ($part_attribute_id) {
        		$partAttribute = $dbPartsCategoryAttribute->find($part_attribute_id)->current();
        		
        		$partAttribute->edit(
        			$part_attribute_id,
        			$part_id,
        			$attribute_id,
        			$new_value
        		);
        	} else {
        		// New part attribute
        		$dbPartsCategoryAttribute->add (
        			$part_id,
        			$attribute_id,
        			$new_value
        		);
        	}
        	$this->_helper->redirector('success', 'part', 'parts', array("message" => "The Part was successfully saved"));
        } else {	
        	$form->part_id->setValue($part_id);
        	$form->attribute_id->setValue($attribute_id);
        	
        	
        	// need to get the valid parts for the drop-down list
        	$attribute = $dbCategoryAttribute->find($attribute_id)->current();
        	$categories = $attribute->getParts();
        	$parts_list = Array();
        	foreach ($categories as $categorypart) {
                foreach ($categorypart as $part) {
                	if (($part->user_id == (int)Genocad_Application::getUser()->user_id) || ($part->user_id == 0)) {
                    	$parts_list[$part->id] = $part->part_id . ' - ' . $part->description;
                	}	
                }
                $form->map_part_id->setMultiOptions($parts_list);
            }
        	
        	if ($part_attribute_id) {
        		// set these values if this is an edit
        		$partAttribute = $dbPartsCategoryAttribute->find($part_attribute_id)->current();
        		// have to decipher the value
        		$tempString = substr(trim($partAttribute->value), 1, strlen(trim($partAttribute->value)) - 2);
                $valueArray = explode(",", $tempString);
                $form->part_attribute_id->setValue($part_attribute_id);
                $form->map_part_id->setValue(trim($valueArray[0]));
                $form->map_value->setValue(trim($valueArray[1]));
        	}
        }
        $this->view->form = $form;	        
    }
    
    public function deleteMappedAction() {
    	$id = $this->_request->getParam('id');
        $dbPartsCategoryAttribute = new Application_Model_DbTable_PartsCategoryAttributes();
        $attribute = $dbPartsCategoryAttribute->find($id)->current();
        $attribute->delete();
        
        $this->view->message = "The mapping has been deleted";
		$this->_helper->redirector('success', 'part', 'parts', array("message" => "The Mapping has been deleted"));
    }
    
    public function deleteAction() {
    	$id = $this->_request->getParam('id');
    	$dbPartsCategoryAttributes = new Application_Model_DbTable_PartsCategoryAttributes();
    	$dbParts = new Application_Model_DbTable_Parts();
    	    	
    	// First, clear out any $dbPartsCategoryAttributes that have this part in the value field
    	$dbPartsCategoryAttributes->deletePartsValues($id);
    	
        $part = $dbParts->find($id)->current();
        $part->delete();
        
       $this->_helper->redirector('success', 'part', 'parts', array("message" => "The Part was successfully deleted"));
         
    }
    
    public function successAction()
    {
    	$message = $this->_request->getParam('message');
        $this->view->response = $message; 
    }
    
}
