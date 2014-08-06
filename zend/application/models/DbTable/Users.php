<?php

class Application_Model_DbTable_Users extends Zend_Db_Table_Abstract
{

    protected $_name = 'users';
    protected $_primary = 'user_id';
    protected $_rowClass = 'Application_Model_DbTable_Row_User';

    public function getUserByLogin($login) {
        return ($this->fetchRow($this->select()->where('login = ?', $login)));
    }

    /**
     * Returns a Rowset of users records that have the security_level set to 'admin'
     * 
     */
    public function getAdminUsers() {
        return ($this->fetchAll($this->select()->where('security_level = ?', 'admin')));
    }

}