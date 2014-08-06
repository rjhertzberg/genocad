<?php

class Application_Model_DbTable_DesignStepParts extends Zend_Db_Table_Abstract
{

    protected $_name = 'design_step_parts';
    protected $_primary = array('step_id', 'category_index');

    protected $_referenceMap    = array(
        'DesignSteps' => array(
            'columns'           => 'step_id',
            'refTableClass'     => 'Application_Model_DbTable_DesignSteps',
            'refColumns'        => 'step_id',
    		'onDelete'          => self::CASCADE
        ),
        'Categories' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id'
        ),
        'Parts' => array(
            'columns'           => 'part_id',
            'refTableClass'     => 'Application_Model_DbTable_Parts',
            'refColumns'        => 'id'
        )
    );

}
