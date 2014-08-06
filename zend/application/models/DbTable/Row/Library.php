<?php

class Application_Model_DbTable_Row_Library extends Zend_Db_Table_Row_Abstract
{
    protected $_parts;

    public function isPublic() {
        return ($this->user_id == 0);
    }

    public function isEditable() {
        return ($this->user_id == (int)Genocad_Application::getUser()->user_id);
    }
    
    /**
     * Returns a single Grammar row for the given Library record
     * 
     * @return Zend_Db_Table_Row_Grammar
     */
    public function getGrammar() {
        return($this->findParentRow('Application_Model_DbTable_Grammars'));
    }
    
    public function getDesigns() {
    	return($this->findDependentRowset('Application_Model_DbTable_Designs'));
    }

    public function getParts() {

        if (null === $this->_parts) {
            $this->_parts = $this->findDependentRowset('Application_Model_DbTable_LibraryParts');
        }
        return ($this->_parts);
    }

    public function hasParts() {
        return ($this->getParts()->count() > 0);
    }
    
	public function hasDesigns() {
        return ($this->getDesigns()->count() > 0);
    }

    public function getPartCount() {
        return ($this->getParts()->count());
    }

    public function addPart($part_id) {

        if ($this->isEditable()) {
            $dbLibraryPart = new Application_Model_DbTable_LibraryParts();
    
            try {
                $dbLibraryPart->addPart($this->library_id, $part_id);
            } catch (Exception $e) {
                var_dump ($e);
            }
        }

    }

    public function removePart($part_id) {

        if ($this->isEditable()) {
            $dbLibraryPart = new Application_Model_DbTable_LibraryParts();
    
            try {
                $dbLibraryPart->removePart($this->library_id, $part_id);
            } catch (Exception $e) {
                var_dump ($e);
            }
        }

    }

    /**
     * Returns a set of category records that are associated with parts in this library
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getCategories() {
        $sqlCategories = 'SELECT distinct category_id FROM library_part_join lp, categories_parts cp where lp.part_id = cp.part_id and lp.library_id = ' . $this->library_id;
        $categoryRows = $this->getTable()->getAdapter()->fetchAll($sqlCategories);
        $dbCategories = new Application_Model_DbTable_Categories();
        $categories = $dbCategories->find($categoryRows);
        return ($categories);
    }

    public function edit ($grammar_id, $name, $description) {

        // if the library has parts, the grammar cannot be changed so make sure 
        // it is set to the current value
        if ($this->hasParts()) {
            $grammar_id = $this->grammar_id;
        }

        $data = array (
                    'grammar_id' => $grammar_id,
                    'name' => $name,
                    'description' => $description,
                    'last_modified' => new Zend_Db_Expr('NOW()')
                );

        $this->setFromArray($data);
        $this->save();

    }

    public function getJsTreeNode($nodeId = '') {

        $id = ($nodeId == '' ? $this->library_id : $nodeId);

        $node = array();
        
        $node["attr"]["id"] = $id;
        $node["data"]["title"] = $this->name;
        $node["data"]["attr"]["id"] = $id;
        if ($this->user_id != 0) {
            $node["data"]["icon"] = new Zend_Json_Expr('"/images/folder_user.png"');
        }

        return ($node);

    }
}