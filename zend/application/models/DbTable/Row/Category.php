<?php

class Application_Model_DbTable_Row_Category extends Zend_Db_Table_Row_Abstract
{
    /**
     * Returns a boolean indicating whether or not this category can be edited
     * by the authenticated user.  Returns true only if the user id of the parent
     * grammar is equivalent to the currently logged in user
     * 
     * @return boolean
     */
    public function isEditable() {

        $user_id = Genocad_Application::getUserID();

        if ($user_id != 0 && $this->getGrammar()->user_id == $user_id) {
            return (true);
        } else {
            return (false);
        }
        
    }

    /**
     * Returns a boolean indicating whether or not this category can be deleted
     * from the system.  Categories can be deleted if they don't have any parts
     * or rules associated with them, and if they belong to a grammar that is owned
     * by the authenticated user
     * 
     * @return boolean
     */
    public function isDeletable() {

        if ($this->isEditable()) {
            
            if (!$this->isOrphaned()) {
                return (false);
            }
          
            if ($this->hasParts()) {
                return (false);
            }

            return (true);

        } else {

            return (false);

        }
        
    }

    
    /**
     * Returns a string that represents the common label for a Category
     * 
     * @return string
     */
    public function getLabel() {
        return $this->description . ' (' . $this->letter . ')';
    }

    /**
     * Returns true/false depending on whether or not the given category
     * has parts associated with it
     * 
     * @return boolean
     */
    public function hasParts() {
        return (count($this->getParts()) > 0);
    }
    
    /**
     * Returns a Rowset of parts records for the current category record
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getParts() {
        return($this->findManyToManyRowset('Application_Model_DbTable_Parts', 'Application_Model_DbTable_CategoryParts'));
    }

    /**
     * Returns the grammar record the category is associated with
     * 
     * @return Zend_Db_Table_Row
     */
    public function getGrammar() {
        return($this->findParentRow('Application_Model_DbTable_Grammars', 'Grammars'));
    }

    /**
     * Returns the genbank qualifier record the category is associated with
     * 
     * @return Zend_Db_Table_Row
     */
    public function getGenbankQualifier() {
        return($this->findParentRow('Application_Model_DbTable_GenbankQualifiers', 'GenbankQualifiers'));
    }

    /**
     * Returns a Rowset of category_attributes records for the current category record
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getAttributes() {
        $select = $this->select()->order(array('display_order'));
        return($this->findDependentRowset('Application_Model_DbTable_CategoryAttributes', 'Categories', $select));
    }
    
	/**
     * Returns a Rowset of attributes_to_pass records for the current category record
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getAttributesToPass() {
        $select = $this->select()->order(array('id'));
        return($this->findDependentRowset('Application_Model_DbTable_AttributesToPass', 'Categories', $select));
    }

    /**
     * Returns true/false depending on whether or not the given category
     * has attributes associated with it
     * 
     * @return boolean
     */
    public function hasAttributes() {
        return (count($this->getAttributes()) > 0);
    }
    
 	/**
     * Returns number of attributes associated with a selected category
     * 
     * @return boolean
     */
    public function countAttributes() {
        return count($this->getAttributes());
    }

    /**
     * Returns a rowset of all of the rules that start with the given category 
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getRules() {
        return($this->findDependentRowset('Application_Model_DbTable_Rules'));
    }

    /**
     * Returns a rowset of distinct rule_id's that where the given category is
     * referenced by a rules_transform record.
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getRuleTransform() {
        $select = $this->select()->distinct()->from(array('p'=> 'rule_transform'), array('rule_id'));
        return ($this->findDependentRowset('Application_Model_DbTable_RuleTransform', 'Categories', $select));
    }

    public function isRewritable() {
        return (count($this->getRules()) != 0);
    }
    
    public function isOrphaned() {
        return (count($this->getRuleTransform()) == 0 && !$this->isRewritable());
    }

    /**
     * Returns the URL for the image associated to the given category.
     * 
     * @return string
     */
    public function getImageUrl() {
        return (($this->icon_name == null ? Application_Model_ImageSets::getDefaultImageUrl() : $this->getGrammar()->getImageUrl() . $this->icon_name));
    }

    /**
     * Returns the URL for the icon associated to the given category.
     * 
     * @return string
     */
    public function getIconUrl() {
        return (($this->icon_name == null ? Application_Model_ImageSets::getDefaultIconUrl() : $this->getGrammar()->getIconUrl() . $this->icon_name));
    }

    public function getJsTreeNode($nodeId) {

        $node = array();

        $node["attr"]["id"] = $nodeId;
        $node["data"]["title"] = $this->getLabel();
        $node["data"]["icon"] = new Zend_Json_Expr(sprintf('"%s"', $this->getIconUrl()));
        $node["data"]["attr"]["id"] = $nodeId;

        return ($node);

    }

}