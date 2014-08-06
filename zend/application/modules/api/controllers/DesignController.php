<?php

class Api_DesignController extends Zend_Controller_Action
{

    public function init()
    {
        $this->db = Zend_Db::factory(Zend_Registry::get('config')->resources->db);
        $this->_helper->layout()->disableLayout();
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('save', 'json')
                      ->addActionContext('load-design', 'json')
                      ->addActionContext('delete', 'json')
                      ->addActionContext('revalidate', 'json')
                      ->initContext('json');
    }

    public function indexAction()
    {
        // action body
    }

    public function saveAction()
    {
        $data = $this->getRequest()->getParams();

        $form = new Design_Form_Design();

        // check to see if the posted data passes the form validation
        if ($form->isValid($data)) {

            // save the Design record
            $designs = new Application_Model_DbTable_Designs();
            $row = $designs->saveDesignForm($form);

        }
        $this->view->data = $row->toArray();
    }

    public function loadDesignAction()
    {

        $dbDesigns = new Application_Model_DbTable_Designs();

        $design_id = $this->getRequest()->getParam('id');

        $design = $dbDesigns->find($design_id)->current();

        $steps = $design->getDesignSteps();

        $steps_arr = Array();

        foreach ($steps as $step) {

            $parts_arr = Array();

            $parts = $step->getDesignStepParts();

            foreach ($parts as $part) {
                $parts_arr[] = array('category_index' => $part->category_index, 'category_id' => $part->category_id, 'part_id'=> $part->part_id);
            }

            $steps_arr[] = $parts_arr;
        }

        $this->view->design = $design->toArray();
        $this->view->data = $steps_arr;
    }

    public function deleteAction()
    {
        $dbDesigns = new Application_Model_DbTable_Designs();
        $designs = $dbDesigns->removeUserDesigns($this->getRequest()->getParam('design_id'));
        $this->view->designs = $designs;

    }

    public function revalidateAction()
    {

        $design_id = $this->getRequest()->getParam('id');
        $dbDesigns = new Application_Model_DbTable_Designs();
        $design = $dbDesigns->find($design_id)->current();

        $this->view->message = $design->validate();

    }
}
