<?php

class Application_Model_DbTable_Settings extends Zend_Db_Table_Abstract
{

    protected $_name = 'settings';
    protected $_primary = 'setting_id';

    public function findByName($name) {
        return $this->fetchRow($this->select()->where('name = ?', $name));
    }

    public function getValue($name) {
        return $this->findByName($name)->value;
    }
}
