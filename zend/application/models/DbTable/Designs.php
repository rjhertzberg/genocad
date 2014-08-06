<?php

class Application_Model_DbTable_Designs extends Zend_Db_Table_Abstract
{

    protected $_name = 'designs';
    protected $_primary = 'design_id';
    protected $_dependentTables = array('Application_Model_DbTable_DesignSteps');
    protected $_rowClass = 'Application_Model_DbTable_Row_Design';

    protected $_referenceMap    = array(
        'Libraries' => array(
            'columns'           => 'library_id',
            'refTableClass'     => 'Application_Model_DbTable_Libraries',
            'refColumns'        => 'library_id'
        )
    );

    /**
     * returns a Rowset of design records that are publically accessible 
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getPublicDesigns() {

        $select  = $this->select()
        				->setIntegrityCheck(false)
        				-> from(array('designs' => 'designs'))
        				-> where('designs.user_id = 0')
                        -> join(array('l' => 'libraries'), 'l.library_id = designs.library_id', array('libname' => 'l.name'))
                		-> join(array('g' => 'grammars'), 'g.grammar_id = l.grammar_id', array('gramname' => 'g.name'));

        return ($this->fetchAll($select));

    }


    /**
     * returns a Rowset of design records owned by the user who is currently
     * logged into the GenoCAD application
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getUserDesigns() {

        $user_id = (int) Genocad_Application::getUserId();
        $select  = $this->select()
        				->setIntegrityCheck(false)
        				-> from(array('designs' => 'designs'))
        				-> where('designs.user_id = '.$user_id)
                        -> join(array('l' => 'libraries'), 'l.library_id = designs.library_id', array('libname' => 'l.name'))
                		-> join(array('g' => 'grammars'), 'g.grammar_id = l.grammar_id', array('gramname' => 'g.name'));
        return ($this->fetchAll($select));

    }

    /**
     * returns a Rowset of design records that can be run through the simulator.
     *  
     * @return Zend_Db_Table_Rowset
     */
    public function getSimulationDesigns($publicOnly = false) {

        $select = $this->select(Zend_Db_Table::SELECT_WITH_FROM_PART);
        $select -> setIntegrityCheck(false)
                -> join(array('l' => 'libraries'), 'l.library_id = designs.library_id', array('libname' => 'l.name'))
                -> join(array('g' => 'grammars'), 'g.grammar_id = l.grammar_id', array('gramname' => 'g.name'))
                -> join(array('ag' => 'attribute_grammar'), 'ag.grammar_id = l.grammar_id', array());
                
        if ($publicOnly) {
            $user_id = 0;
        } else {
            $user_id = (int) Genocad_Application::getUserId();
        }

        $select -> where('designs.user_id = ?', $user_id);

        return ($this->fetchAll($select));

    }
    

    /**
     * Saves a design based on the values provided by the Design Form
     * 
     * @param Design_Form_Design $form
     */
    public function saveDesignForm(Design_Form_Design $form) {

        $design_id = $form->getValue('design_id');

        $dbSteps = new Application_Model_DbTable_DesignSteps();
        $dbStepParts = new Application_Model_DbTable_DesignStepParts();

        // if the design_id is null, then it's a new row
        if ($design_id == '') {
            $data = array (
                'name' => $form->getValue('design_name'),
                'description' => $form->getValue('design_description'),
                'user_id' => (int)Genocad_Application::getUser()->user_id,
                'last_modification' => new Zend_Db_Expr('NOW()'),
                'library_id' => $form->getValue('design_library_id'),
                'is_public' => 0
            );
            $row = $this->createRow($data);
        } else {
            // retrieve the design record for the given design_id
            $row = $this->find($design_id)->current();

            // set the proper values for the design record
            $row->name = $form->getValue('design_name');
            $row->description = $form->getValue('design_description');
            $row->library_id = $form->getValue('design_library_id');
            $row->last_modification = new Zend_Db_Expr('NOW()');
        }

        $row->save();

        // set the design_id variable to the value of the PK for the row
        $design_id = $row->design_id;

        // After the row is saved, delete all of the design steps for this design
        $dbSteps->delete($dbSteps->getAdapter()->quoteInto('design_id = ?', $design_id));

        // the design steps form element will contain a JSON encoded string that
        // represents the step history of the design.  This needs to be converted
        // and saved into the design_steps and design_step_parts tables
        $steps = Zend_Json::decode($form->getValue('design_steps'));

        $db = $this->getAdapter();

        foreach ($steps as $step_index => $step) {

            $step_data = array ('step_index' => $step_index, 'design_id' => $design_id);
            $step_row = $dbSteps->createRow($step_data);
            $step_row->save();

            $step_elements = Zend_Json::decode($step);

            $sql = 'insert into design_step_parts (step_id, category_index, category_id, part_id) values ';

            foreach ($step_elements as $category_index => $element) {

                $part_data = array ( 
                                'step_id'=> $step_row->step_id,
                                'category_index' => $category_index, 
                                'category_id' => $element["category_id"], 
                                'part_id' => ($element["part_id"] == "" ? 'null' : $element["part_id"])
                             );

               if ($category_index != 0) {
                   $sql .= ',';
               }
               $sql .= sprintf('(%s,%s,%s,%s)', $part_data['step_id'], $part_data['category_index'], $part_data['category_id'], $part_data['part_id']);
                
            }
            //var_dump($sql);
            $stmt = $db->prepare($sql);
            $stmt->execute();

        }

        $row->sequence = $row->generateSequence();
        
        // set the is_validated status
        if (strlen($row->sequence) == 0) {
            $row->is_validated = -1;
        } else if ($row->isUnderConstruction()) {
            $row->is_validated = -2;
        } else {
            $row->is_validated = $row->getLibrary()->getGrammar()->is_compilable;
        }

        $row->save();

        return ($row);

    }


    /**
     * 
     * @param unknown_type $design_id
     * @param unknown_type $new_name
     */
    public function cloneDesign($design_id) {

        $dbSteps = new Application_Model_DbTable_DesignSteps();
        $dbStepParts = new Application_Model_DbTable_DesignStepParts();

        // Find the design record being copied
        $design = $this->find($design_id)->current();

        $data = $design->toArray();
        unset($data['design_id']);
        $data['name'] = 'Copy of ' . $design->name;
        $data['last_modification'] =  new Zend_Db_Expr('NOW()');
        $data['user_id'] = Genocad_Application::getUserId();
        $data['is_public'] = 0;

        $new_design = $this->createRow($data);
        $new_design->save();

        $steps = $design->getDesignSteps();
        $db = $this->getAdapter();
        foreach ($steps as $step) {
            $new_step = $dbSteps->createRow(array('step_index'=>$step->step_index, 'design_id'=>$new_design->design_id));
            $new_step->save();
            
            // use the following query to insert the step parts 
            $sql = sprintf('insert into design_step_parts (step_id, category_index, category_id, part_id) (select %s, category_index, category_id, part_id from design_step_parts where step_id = %s)', $new_step->step_id, $step->step_id);
            $stmt = $db->prepare($sql);
            $stmt->execute();
        }

    }

    
    public function removeUserDesigns($designs) {

        $designs = $this->find($designs);
        $return_val = $designs->toArray();
        $user_id = (int) Genocad_Application::getUser()->user_id;

        foreach ($designs as $design) {
            if ($design->user_id == $user_id) {
                $design->delete();
            }
        }

        return($return_val);

    }
}