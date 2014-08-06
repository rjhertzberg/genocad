<?php

class Application_Model_DbTable_Row_Part extends Zend_Db_Table_Row_Abstract
{
    public function getGrammar() {
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $grammarRows = $dbGrammars->fetchAll($dbGrammars->select()->where('grammar_id in (select grammar_id from categories c, categories_parts cp where cp.category_id = c.category_id and cp.part_id = ?)', $this->id));
        return($grammarRows->current());
    }

    public function getLibraries() {
        return($this->findDependentRowset('Application_Model_DbTable_LibraryParts'));
    }

    public function getDesigns() {

        $dbDesigns = new Application_Model_DbTable_Designs();
        $designs = $dbDesigns->fetchAll($dbDesigns->select()->where('design_id in (select design_id from design_steps ds, design_step_parts dsp where ds.step_id = dsp.step_id and dsp.part_id = ?)', $this->id));

        return ($designs);
    }

    public function getAttributes() {
    	return($this->findDependentRowset('Application_Model_DbTable_PartsCategoryAttributes'));
    }
    
    /*
     * Returns the number of designs that this part has been used in
     * 
     * @return integer
     * 
     */
    public function getDesignCount() {

        return (count($this->getDesigns()));

    }
    
    /*
     * This function returns an array of library_id values that represent the
     * libraries that this part resides in for the given user
     */
    public function getUserLibraryIds($user_id) {

        $rsLibraries = $this->getLibraries();
        $libraries = array();

        foreach ($rsLibraries as $rowLibrary) {

            $library = $rowLibrary->findParentRow('Application_Model_DbTable_Libraries');

            if (isset($library) && $library->user_id == $user_id) {
                $libraries[] = $library->library_id;
            }
        }

        return ($libraries);
    }

    /*
     * This function returns an array of library_id values that represent the
     * libraries that this part resides in for the given user or the public
     */
    public function getUserandPublicLibraryIds($user_id) {

        $rsLibraries = $this->getLibraries();
        $libraries = array();

        foreach ($rsLibraries as $rowLibrary) {

            $library = $rowLibrary->findParentRow('Application_Model_DbTable_Libraries');

            if (isset($library) && ($library->user_id == $user_id || $library->user_id == 0)) {
                $libraries[] = $library->library_id;
            }
        }

        return ($libraries);
    }

    /*
     * This function returns a key/value array that contains a listing of 
     * user and public libraries for the given grammar
     */
    public function getUserandPublicLibraryList($user_id) {

        $rsLibraries = $this->getLibraries();
        $libraries = array();

        foreach ($rsLibraries as $rowLibrary) {

            $library = $rowLibrary->findParentRow('Application_Model_DbTable_Libraries');

            if (isset($library) && ($library->user_id == $user_id || $library->user_id == 0)) {
                $libraries[] = array("key"=> $library->library_id, "value"=> $library->name);
            }
        }

        return ($libraries);
    }

    /*
     * This function returns an array of category id's and values that is used
     * to populate a form select list.  This function will return all of the
     * "selected" categories for the given Part.
     */
    public function getCategories() {
        $rsCategories = $this->findDependentRowset('Application_Model_DbTable_CategoryParts');
        $categories = Array();
        foreach ($rsCategories as $category) {
            $categories[] = $category->findParentRow('Application_Model_DbTable_Categories');
        }
        return ($categories);
    }
    
    /*
     * This function returns an array of category id's and values that is used
     * to populate a form select list.  This function will return all of the
     * "selected" categories for the given Part.
     */
    public function getCategoryList() {
        $rsCategories = $this->findDependentRowset('Application_Model_DbTable_CategoryParts');
        $categories = Array();
        foreach ($rsCategories as $category) {
            $cat = $category->findParentRow('Application_Model_DbTable_Categories');
            $categories[] = array("key"=> $cat->category_id, "value"=> $cat->getLabel());
        }
        return ($categories);
    }

    /*
     * This function returns an array of category_id values that represent the
     * categories chosen for this part.
     */
    public function getCategoryIds() {
        $rsCategories = $this->getCategories();

        foreach ($rsCategories as $rowCategory) {
            $categories[] = $rowCategory->category_id;
        }

        return($categories);

    }
    
    /*
     * GetSearchCategories
     * 
     * Returns a string with all the categories for a given part formatted as "grammar_id|grammar_name|letter|category;grammar_id|grammar_name|letter|category"
     * Used by search
     */
    public function getSearchCategories() {
    	$rsCategories = $this->findDependentRowset('Application_Model_DbTable_CategoryParts');
        
    	$categoryString = "";
        foreach ($rsCategories as $partCategory) {
            $category = $partCategory->findParentRow('Application_Model_DbTable_Categories');
            if ($categoryString != "") {
            	$categoryString .= ";";
            }
            
            $grammar = $category->getGrammar();
            $categoryString .= $grammar->grammar_id.'|'.$grammar->name.'|'.$category->letter.'|'.$category->description;
        }
        
        return ($categoryString);
    	
    }


    /**
     * Returns true if the Part record is publically available
     * 
     * @returns boolean
     */
    public function isPublic() {
        return ($this->user_id == 0);
    }

    /**
     * Returns true if the Part is "owned" by the user who is currently logged in
     * 
     * @returns boolean
     */
    public function isEditable() {
        return ($this->user_id == (int)Genocad_Application::getUser()->user_id);
    }

    public function addLibrary($library_id) {

        if ($this->isEditable()) {
            $dbLibraryPart = new Application_Model_DbTable_LibraryParts();
    
            try {
                $dbLibraryPart->addPart($library_id, $this->id);
            } catch (Exception $e) {
                var_dump ($e);
            }
        }

    }

    public function removeLibraries($library_id) {

        if ($this->isEditable()) {
            $dbLibraryPart = new Application_Model_DbTable_LibraryParts();
    
            try {
                $dbLibraryPart->removePart($library_id, $this->id);
            } catch (Exception $e) {
                var_dump ($e);
            }
        }

    }

    /*
    *  cleanSegment removes extraneous characters from the sequence field (like carriage returns and spaces.)
    */
    public function cleanSegment($field){
    	$screenChars = array(" ", "\r\n", "\r", "\n");
    	return str_replace($screenChars, "", $field);
    }
    
    public function edit ($id, $part_id, $description, $segment, $description_text, $libraries, $categories) {

    	if ($segment == "||") { // model character
        	$segment = "";
        }	
        
        $data = array (
                    'id' => $id,
                    // Don't update the part id... 'part_id' => $part_id,
                    'description' => $description,
                    'segment' => $this->cleanSegment($segment),
                    'description_text' => $description_text,
                    'last_modified' => new Zend_Db_Expr('NOW()')
        );

        $this->setFromArray($data);
        $this->save();

        $dbLibraryParts = new Application_Model_DbTable_LibraryParts();
        $dbCategoryParts = new Application_Model_DbTable_CategoryParts();

        $current_libs = $this->getLibraries();
        foreach ($current_libs as $lib) {
            $dbLibraryParts->removePart($lib->library_id, $id);
        }

        foreach ($libraries as $lib) {
            $dbLibraryParts->addPart($lib, $id);
        }

        $current_cats = $this->findDependentRowset('Application_Model_DbTable_CategoryParts');

        foreach ($current_cats as $cat) {
            $dbCategoryParts->remove($cat->id);
        }

        foreach ($categories as $cat) {
            $dbCategoryParts->add($cat, $id, $this->user_id);
        }

        // update the designs that use this part
        foreach ($this->getDesigns() as $design) {
            $design->is_validated = 0;
            $design->save();
        }

    }

    public function export($format) {
        
        $categories = $this->findManyToManyRowset('Application_Model_DbTable_Categories','Application_Model_DbTable_CategoryParts');
        $arrCategories = array();

        foreach ($categories as $category) {
            $arrCategories[] = $category->letter;
        }

        if ($format == "FASTA") {
            return ('>lcl|'. $this->description . '|' . implode(",", $arrCategories) . PHP_EOL . chunk_split(strtoupper(str_replace(Array(" ", PHP_EOL, chr(9)), "", $this->segment)), 80, PHP_EOL));
        } else {
            return ($this->description . chr(9) . implode(",", $arrCategories) . chr(9) . str_replace(Array(PHP_EOL, chr(9)), " ", $this->description_text) . chr(9) . str_replace(Array(" ", PHP_EOL), "", strtoupper(str_replace(Array(" ", PHP_EOL, chr(9)), "", $this->segment))) . PHP_EOL);
        }

    }
    
     /**
     * Checks to see if this part has any category attributes that have not
     * been populated and returns true/false based on its findings
     * 
     * @returns boolean
     */
    public function hasEmptyAttributes() {
        foreach ($this->getCategories() as $category) {
            foreach ($category->getAttributes() as $attribute) {
                $values = $attribute->getPartValues($this->id);
                $countVal = 0; 
                foreach ($values as $value) {
                	$countVal += 1;
                	if ($value->value == "") {
                    	return (true);
                	}
                }
                if ($countVal == 0) {
                	return (true);
                }	
            }
        }
        return (false);
    }

}