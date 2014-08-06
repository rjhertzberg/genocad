<?php

class Application_Model_DbTable_DesignSteps extends Zend_Db_Table_Abstract
{

    protected $_name = 'design_steps';
    protected $_primary = 'step_id';
    protected $_dependentTables = array('Application_Model_DbTable_DesignStepParts');
    protected $_rowClass = 'Application_Model_DbTable_Row_DesignStep';

    protected $_referenceMap    = array(
        'Designs' => array(
            'columns'           => 'design_id',
            'refTableClass'     => 'Application_Model_DbTable_Designs',
            'refColumns'        => 'design_id',
    		'onDelete'          => self::CASCADE
        )
    );

}