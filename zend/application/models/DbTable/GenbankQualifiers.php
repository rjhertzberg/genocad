<?php

class Application_Model_DbTable_GenbankQualifiers extends Zend_Db_Table_Abstract
{

    protected $_name = 'genbank_qualifiers';
    protected $_primary = 'genbank_qualifier_id';
    protected $_dependentTables = array('Application_Model_DbTable_Categories');

}
