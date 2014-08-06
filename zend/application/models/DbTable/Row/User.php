<?php

class Application_Model_DbTable_Row_User extends Zend_Db_Table_Row_Abstract
{

    public function setPassword($password) {
        $this->password = md5($password);
        $this->save();
    }


}