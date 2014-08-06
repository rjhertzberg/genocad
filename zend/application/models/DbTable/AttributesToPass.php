<?php

class Application_Model_DbTable_AttributesToPass extends Zend_Db_Table_Abstract
{

    protected $_name = 'attributes_to_pass';
    protected $_primary = 'id';

    protected $_referenceMap    = array(
        'Categories' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id'
        ),
        'CategoryAttributes' => array(
            'columns'           => 'attribute_id',
            'refTableClass'     => 'Application_Model_DbTable_CategoryAttributes',
            'refColumns'        => 'id'
        )
    );
}

