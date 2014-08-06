<?php

class Application_Model_DbTable_LibraryParts extends Zend_Db_Table_Abstract
{

    protected $_name = 'library_part_join';
	protected $_primary = array('library_id', 'part_id');

	protected $_referenceMap    = array(
        'Libraries' => array(
            'columns'           => 'library_id',
            'refTableClass'     => 'Application_Model_DbTable_Libraries',
            'refColumns'        => 'library_id',
	        'onDelete'          => self::CASCADE
        ),
        'Parts' => array(
            'columns'           => 'part_id',
            'refTableClass'     => 'Application_Model_DbTable_Parts',
            'refColumns'        => 'id',
            'onDelete'          => self::CASCADE
        )
    );

	public function addPart($library_id, $part_id) {

		$data = array ('library_id' => $library_id, 'part_id' => $part_id);
		try {
			$this-> insert($data);
		} catch (Exception $e) {
			// don't do anything here -- just trying to duplicate entry
		}	

	}

    public function removePart($library_id, $part_id) {

        $rows = $this->find($library_id, $part_id);
        if ($rows) {
            $rows->current()->delete();
        }

    }

}