<?php

/**
 * Application_Model_DbTable_Parts
 *
 * @author Russell J. Hertzberg
 * @version
 */

class Application_Model_DbTable_Parts extends Zend_Db_Table_Abstract {

    protected $_name = 'parts';
    protected $_primary = 'id';
    protected $_dependentTables = array('Application_Model_DbTable_LibraryParts', 'Application_Model_DbTable_DesignStepParts', 'Application_Model_DbTable_PartsCategoryAttributes', 'Application_Model_DbTable_CategoryParts');
    protected $_rowClass = 'Application_Model_DbTable_Row_Part';

    public function getPart($id) {

        return ($this->find($id)->current());
        
    }

    public function getPartbyPartID ($part_id) {
        
        return ($this->fetchRow($this->select()->where('part_id = ?', $part_id)));

    }


    public function getPartbySequence ($sequence) {
        return ($this->fetchRow($this->select()->where('segment = ?', $sequence)));
    }

    public function isPartIDAvailable ($part_id) {
        
        $part = $this->getPartbyPartID($part_id);
        if ($part) {
            return false;
        } else {
            return true;
        }

    }

    /*
     * getNextPartID
     */
    public function getNextPartID () {

        // get the last used PartID from the settings table
        $dbSetting = new Application_Model_DbTable_Settings();
        $setting = $dbSetting->findByName('LAST_PART_ID');
        $lastPartID = $setting->value;

        $digit = -1;
        $done = false;

        while (!$done) {

            // get the ascii value of the character in the $digit position of the $lastPartID
            $ascii_val = ord(substr($lastPartID, $digit, 1));

            if ($ascii_val == 57) {
                // if the digit is a '9', set the next one to 'a'
                $ascii_val = 97;
                $done = true;
            } else if ($ascii_val == 122) {
                // if the digit is a 'z', then reset it to '0', and check previous digit
                $ascii_val = 48;
                $digit -= 1;
            } else {
                // otherwise, just add one to the digit
                $ascii_val += 1;
                $done = true;
            }

            if ($done) {

                // create the new Part ID by "adding" one to the digit
                $newPartID = str_pad(substr($lastPartID, 0, (5 + $digit)) . chr($ascii_val), 5, '0', STR_PAD_RIGHT);

                // Make sure that the new Part ID is not already in use
                if (!$this->isPartIDAvailable($newPartID)) {
                    $done = false;
                    $lastPartID = $newPartID;
                    $digit = -1;
                }

            }
            
        }

        // update the LAST_PART_ID setting
        $setting->value = $newPartID;
        $setting->save();
        return ($newPartID);

    }
    
   /*
    *  cleanSegment removes extraneous characters from the sequence field (like carriage returns and spaces.)
    */
    public function cleanSegment($field){
    	$screenChars = array(" ", "\r\n", "\r", "\n");
    	return str_replace($screenChars, "", $field);
    }

    public function add ($description, $segment, $description_text, $libraries, $categories) {


        $dbLibraryParts = new Application_Model_DbTable_LibraryParts();
        $dbCategoryParts = new Application_Model_DbTable_CategoryParts();
        $dbCategory = new Application_Model_DbTable_Categories();
        $dbAttributes = new Application_Model_DbTable_CategoryAttributes();
        $dbPartsCategoryAttributes = new Application_Model_DbTable_PartsCategoryAttributes();
        if ($segment == "||") { // model character
        	$segment = "";
        }	

        $data = array (
                    'part_id' => $this->getNextPartID(),
                    'description' => $description,
                    'segment' => $this->cleanSegment($segment),
                    'user_id' => (int)Genocad_Application::getUser()->user_id,
                    'description_text' => $description_text,
                    'last_modified' => new Zend_Db_Expr('NOW()'),
                    'date_created' => new Zend_Db_Expr('NOW()')
        );


        $row = $this->createRow($data);
        $row->save();

        foreach ($libraries as $lib) {
            $dbLibraryParts->addPart($lib, $row->id);
        }

        foreach ($categories as $cat) {
            $dbCategoryParts->add($cat, $row->id, $row->user_id);
            
            $category = $dbCategory->find($cat)->current();
            
            $attributes = $category->getAttributes();
            foreach ($attributes as $attribute) {
            	if (($attribute->attribute_type_id == 0) || ($attribute->attribute_type_id == 3)) 
            		$dbPartsCategoryAttributes->set($row->id, $attribute->id, "");
            }
        }
        
        return($row);

    }

    public function edit ($id, $part_id, $description, $segment, $description_text, $user_id) {

        $data = array (
                    'id' => $id,
                    'description' => $description,
                    'segment' => $segment,
                    'description_text' => $description_text,
                    'last_modified' => new Zend_Db_Expr('NOW()')
        );

        $this->update($data);

    }

    public function remove ($id) {

        $data = array (
                    'id' => $id
        );

        $this->table->delete($data);

    }


    /**
     * Retrieves a rowset of parts for a given library and category id
     * 
     * @param integer $library_id
     * @param integer $category_id
     */
    public function getPartsByLibraryCategory($library_id, $category_id) {

        $select = $this->select(Zend_Db_Table::SELECT_WITH_FROM_PART);
        $select -> setIntegrityCheck(false)
                -> join(array('lpj' => 'library_part_join'), 'lpj.part_id = parts.id', array())
                -> join(array('cp' => 'categories_parts'), 'cp.part_id = parts.id', array())
                -> where('lpj.library_id = ?', $library_id)
                -> where('cp.category_id = ?', $category_id);

        return($this->fetchAll($select));

    }
    
 /**
     * Retrieves a rowset of parts for a given category id
     * 
     * @param integer $library_id
     * @param integer $category_id
     */
    public function getPartsByCategory($category_id) {

        $select = $this->select(Zend_Db_Table::SELECT_WITH_FROM_PART);
        $select -> setIntegrityCheck(false)
                -> join(array('cp' => 'categories_parts'), 'cp.part_id = parts.id', array())
                -> where('cp.category_id = ?', $category_id);

        return($this->fetchAll($select));

    }
    
 /**
     * Adds special case parts (reverse complement, plasmid, and chromosome) to the library
     * 
     * @param integer $library_id
     * @param integer $category_id
     */
    public function addSpecialCasePart($library_id, $grammar_id, $segment) {
    	$dbCategories = new Application_Model_DbTable_Categories();
    	$dbParts = new Application_Model_DbTable_Parts();
    	$dbLibraryParts = new Application_Model_DbTable_LibraryParts();
    	
    	$category = $dbCategories->getCategoryByLetterAndGrammar($segment, $grammar_id, "");
    	
    	if ($category) {
    	    // there should only be one, but this handles the zero case
    		$parts = $dbParts->getPartsByCategory($category->category_id);
    	    $nb_parts = count($parts);
    		
    		if ($nb_parts == 0) {
    			// need to add the part
    			$part = $dbParts->add($category->description, $segment, "", array("library_id" => $library_id), array("category_id" => $category->category_id));
    		} else {
    			foreach($parts as $part) {
    				$dbLibraryParts->addPart($library_id, $part->id);
    			}
    		}
    		
    	}

    }

}
