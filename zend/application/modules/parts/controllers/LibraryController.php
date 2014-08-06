<?php

class Parts_LibraryController extends Zend_Controller_Action
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
        $library = new Application_Model_DbTable_Libraries();
        $myLibraries = $library->findMyLibraries(100);
        $this->view->libs = $myLibraries;
    }

    public function addAction()
    {
        // instantiate the Library Form
        $form = new Parts_Form_Library();

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();

            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                // save the library record
                $library = new Application_Model_DbTable_Libraries();

                $library->addLibrary (
                    (int) $form->getValue('grammar_id'),
                    $form->getValue('name'),
                    $form->getValue('description'),
                    (int)Genocad_Application::getUser()->user_id
                );

                $this->_helper->redirector('success');

            }

        }

        $this->view->form = $form;
    }

    public function editAction()
    {
        // instantiate the Library Form
        $form = new Parts_Form_Library();

        // instantiate the Libraries model and get the requested library record
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $library = $dbLibraries->getLibrary($this->getRequest()->getParam('id'));

        // check to see if the library is editable
        if (!$library->isEditable()) {
            $form->addError('You do not have permission to edit this Library');
        }

        // if the library already has parts, need to disable the grammar select box
        if ($library->hasParts()) {
            $form->grammar_id->setAttrib('disabled', true);
        }

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();
            $data["grammar_id"] = $data["orig_grammar_id"];

            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                $library->edit (
                    (int) $form->getValue('grammar_id'),
                    $form->getValue('name'),
                    $form->getValue('description')
                );

                $this->_helper->redirector('success');

            }

        } else {

            // the user has not submitted a form
            // populate the form with the selected library
            $form->populate($library->toArray());
            $form->orig_grammar_id->setValue($library->grammar_id);

        }

        $this->view->form = $form;
    }

    public function cloneAction()
    {
        // instantiate the Library Form
        $form = new Parts_Form_Library();
        $dbLibraries = new Application_Model_DbTable_Libraries();

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();
            if ($data["orig_grammar_id"] != 0) {
                $data["grammar_id"] = $data["orig_grammar_id"];
            }

            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                // save the library record
                $dbLibraries->cloneLibrary (
                    (int)$form->getValue('library_id'),
                    (int)$data['grammar_id'],
                    $form->getValue('name'),
                    $form->getValue('description'),
                    (int)Genocad_Application::getUser()->user_id
                );

                $this->_helper->redirector('success');

            }

        } else {

            $library = $dbLibraries->getLibrary($this->getRequest()->getParam('id'));
            $form->populate($library->toArray());
            $form->name->setValue('(Copy) ' . $form->name->getValue());
        
            // if the library already has parts, need to disable the grammar select box
            if ($library->hasParts()) {
                $form->grammar_id->setAttrib('disabled', true);
                $form->orig_grammar_id->setValue($library->grammar_id);
            }
            
        }

        $this->view->form = $form;
    }

    public function deleteAction()
    {
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $library = $dbLibraries->getLibrary($this->getRequest()->getParam('id'));
        
        // MySQL has some nasty traits; you can have foreign keys that restrict the deletion
        // of a library record, but while that may prevent the library record from being deleted, it will
        // not prevent other children from being deleted.  Have to check for designs, else library_parts will be deleted

        if ($library->isEditable()) {
        	if ($library->hasDesigns()) {
        		// don't delete
        	} else {
            	$library->delete();
            	$this->_helper->redirector('success');
        	}	
        }
    }

    public function removepartsAction()
    {

        // first, select the requested library
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $library = $dbLibraries->getLibrary($this->getRequest()->getParam('id'));
        $parts = $this->_request->getParam('part_id');

        // make sure the user has the permissions to edit the library
        if ($library->isEditable()) {

            // check to see if this is an array of parts, if so loop an remove each one
            if (is_array($parts)) {
                foreach ($parts as $part) {
                    $library->removePart($part);
                }
            } else {
                $library->removePart($parts);
            }
        }

    }

    public function successAction()
    {
        $this->view->response = "The Library has been saved successfully"; 
    }
    
}
