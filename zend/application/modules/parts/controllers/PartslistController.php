<?php

class Parts_PartslistController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // action body
    }


    public function addAction()
    {
        try {
            $dbPartsList = new Application_Model_DbTable_PartsList();
            $dbPartsList->addParts(Genocad_Application::getPartsList()->id, $_POST["part_id"]);
        } catch (Exception $e) {
            var_dump($e);
        }
    }

    public function removeAction()
    {

        $parts = $this->_request->getParam('part_id');

        try {
            $dbPartsList = new Application_Model_DbTable_PartsList();
            $dbPartsList->removeParts(Genocad_Application::getPartsList()->id, $parts);
        } catch (Exception $e) {
            var_dump($e);
        }

    }

    public function emptyAction()
    {
        $dbPartsList = new Application_Model_DbTable_PartsList();
        $dbPartsList->emptyParts(Genocad_Application::getPartsList()->id);
    }

    public function mergeAction()
    {
        try {

            $parts = $this->_request->getParam('part_id');
            $library_id = $this->_request->getParam('library_id');
            $remove = $this->_request->getParam('remove');

            $dbLibrary = new Application_Model_DbTable_Libraries();
            $library = $dbLibrary->getLibrary($library_id);

            if ($library->isEditable()) {

                if (is_array($parts)) {
                    foreach ($parts as $part) {
                        $library->addPart($part);
                    }
                } else {
                    $library->addPart($parts);
                }

                if (isset($remove)) {
                    $dbPartsList = new Application_Model_DbTable_PartsList();
                    $dbPartsList->removeParts(Genocad_Application::getPartsList()->id, $parts);
                }

            } else {
                $errors[] = 'You do not have permission to edit this Library';
            }


            $this->view->parts = $parts;

        } catch (Exception $e) {
            var_dump($e);
        }
    }

}
