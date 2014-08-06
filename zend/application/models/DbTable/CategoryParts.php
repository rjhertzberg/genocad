<?php

class Application_Model_DbTable_CategoryParts extends Zend_Db_Table_Abstract
{

    protected $_name = 'categories_parts';
	protected $_primary = 'id';

	protected $_referenceMap    = array(
        'Categories' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id'
        ),
        'Parts' => array(
            'columns'           => 'part_id',
            'refTableClass'     => 'Application_Model_DbTable_Parts',
            'refColumns'        => 'id',
            'onDelete'          => self::CASCADE
        )
    );

	public function add ($category_id, $part_id, $user_id) {

		$data = array (
		          'category_id' => $category_id, 
		          'part_id' => $part_id,
		          'user_id' => $user_id,
		          'last_modified' => new Zend_Db_Expr('NOW()')
		);

		$this-> insert($data);

	}

    public function remove($id) {

        $rows = $this->find($id);
        if ($rows) {
            $rows->current()->delete();
        }

    }

    public function getPartCountByCategory ($category_id) {

        $select = $this->select()
                       ->from($this, array('COUNT(1) as count'))
                       ->where('category_id = ?', $category_id);

        return($this->fetchRow($select)->count);

    }

}