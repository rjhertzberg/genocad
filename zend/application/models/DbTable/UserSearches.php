<?php

class Application_Model_DbTable_UserSearches extends Zend_Db_Table_Abstract
{

    protected $_name = 'user_searches';
    protected $_primary = 'search_id';

    public function findUserSearches() {

        $select = $this->select()
                       ->where('user_id = ?', (int)Genocad_Application::getUser()->user_id);

        return($this->fetchAll($select));

    }

    public function findUserSearchbyName($name) {

        $select = $this->select()
                       ->where('name = ?', $name)
                       ->where('user_id = ?', (int)Genocad_Application::getUser()->user_id);

        return($this->fetchAll($select));

    }
    public function add($name, $query) {

        $data = array (
                    'name' => $name, 
                    'query' => $query,
                    'user_id' => (int)Genocad_Application::getUser()->user_id
        );

        return ($this->insert($data));
    }


    public function edit ($id, $name, $query) {

        $data = array (
                    'search_id' => $id,
                    'name' => $name, 
                    'query' => $query
        );

        $this->update($data);

    }
    
    
}
