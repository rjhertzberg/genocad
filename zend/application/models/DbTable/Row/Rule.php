<?php

class Application_Model_DbTable_Row_Rule extends Zend_Db_Table_Row_Abstract
{

    public function edit ($id, $code, $category_id, $grammar_id, $transform) {

        $dbRuleTransform = new Application_Model_DbTable_RuleTransform();

        $data = array (
        	'rule_id' => $id,
            'code' => $code,
            'category_id' => $category_id,
            'grammar_id' => $grammar_id
        );

        $this->setFromArray($data);
        $this->save();
        
        // delete ruleTransforms and replace with new set
        $rows = $dbRuleTransform->getByRule($this->rule_id);
        foreach($rows as $row) {
        	$row->delete();
        }

        foreach ($transform as $key => $category) {
        	try {
        		$dbRuleTransform->add($this->rule_id, $category, $key);
        	} catch (Exception $e) {
        	} 
        }

        return ($this);
    }
	
    /**
     * @return Zend_Db_Table_Row
     */
    public function getCategory() {
        return ($this->findParentRow('Application_Model_DbTable_Categories'));
    }

    /**
     * Returns a Rowset of rule_transform records for the current rule record
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getRuleTransform() {
        $select = $this->select()->order(array('transform_order'));
        return($this->findDependentRowset('Application_Model_DbTable_RuleTransform', 'Rules', $select));
    }
    
    /**
     * Get list of categories for the dropdown list on the Rule Semantic Action edit page
     */
    
    public function getRuleCategories () {
    	$tempCategories = Array();
    	$dbCategories = new Application_Model_DbTable_Categories();
    	// first get the parent category (note: need to find out if this can be o1)
    	
    	$parentCategory = $this->getCategory();
    	
    	$categories[] = array("key"=> "^C-".$parentCategory->letter."^", "value"=> $parentCategory->getLabel()."-Left Side");
    	
    	// now get children -- a little trickier, because we need to keep track of occurrence.
    	$ruleTransforms = $this->getRuleTransform();
    	
    	foreach ($ruleTransforms as $transform) {
    		//first build array of categories so we know which ones are multiples
    		if (isset($tempCategories[$transform->category_id])) {
    			$tempCategories[$transform->category_id]["totalCount"] = $tempCategories[$transform->category_id]["totalCount"] + 1;
    		} else {
    			$tempCategories[$transform->category_id] = array("totalCount" => 1);
    		}
    	}
    	
    	// okay, go through again, this time adding to categories array
    	foreach ($ruleTransforms as $transform) {
    		$occuranceCount = 0;
    		// get the category
    		$category = $dbCategories->find($transform->category_id)->current();
    		
    		// check $tempCategories to see if there are multiple
    		if ($tempCategories[$category->category_id]["totalCount"] > 1) {
    			$occuranceCount = $tempCategories[$category->category_id]["totalCount"]-1;
    			$tempCategories[$category->category_id]["totalCount"] = $occuranceCount;
    			$occurrenceText = "-o".$occuranceCount;
    		} else {
    			$occurrenceText ="";
    		}
    		
    		if ($category->isRewritable()) {
    			$keyName = "^C-".$category->letter."^";
    			$displayName = $category->getLabel();
    		} else {
    			$keyName = "^Name-".$category->letter.$occurrenceText."^";
    			$displayName = $category->getLabel();
    		}

    		$categories[] = array("key" => $keyName, "value" => $displayName);	
    		 		
    	}
    	   
    	return($categories);
    }

	public function getRuleCategoryAttributes () {
    	$tempCategories = Array();
    	$dbCategories = new Application_Model_DbTable_Categories();
    	$attributes = Array();
    	
    	// first get the parent category (note: need to find out if this can be o1)
    	
    	$parentCategory = $this->getCategory();
    	
    	// Get attributes for the parent category -- this may need to change
    	$rsAttributes = $parentCategory->getAttributes();
    	foreach ($rsAttributes as $attribute) {
    		$keyName = "^A-".$attribute->name."(".$parentCategory->letter.")^";
    		$displayName = $attribute->name."(".$parentCategory->letter.")";
    		
    		$attributes[] = array("key"=>$keyName, "value" => $displayName);
    	}
    	
    	// Add parent to tempCategories so we get the numbering right
    	$tempCategories[$parentCategory->category_id] = array("totalCount" => 1);
    	
    	// now get children -- a little trickier, because we need to keep track of occurrence.
    	$ruleTransforms = $this->getRuleTransform();
    	
    	// now get children -- a little trickier, because we need to keep track of occurrence.
    	$ruleTransforms = $this->getRuleTransform();
    	
    	foreach ($ruleTransforms as $transform) {
    		//first build array of categories so we know which ones are multiples
    		if (isset($tempCategories[$transform->category_id])) {
    			$tempCategories[$transform->category_id]["totalCount"] = $tempCategories[$transform->category_id]["totalCount"] + 1;
    		} else {
    			$tempCategories[$transform->category_id] = array("totalCount" => 1);
    		}
    	}
    	
    	// okay, go through again, this time adding to categories array
    	foreach ($ruleTransforms as $transform) {
    		$occuranceCount = 0;
    		// get the category
    		$category = $dbCategories->find($transform->category_id)->current();
    		
    		// check $tempCategories to see if there are multiple
    		if ($tempCategories[$category->category_id]["totalCount"] > 1) {
    			$occuranceCount = $tempCategories[$category->category_id]["totalCount"]-1;
    			$tempCategories[$category->category_id]["totalCount"] = $occuranceCount;
    			$occurrenceText = "-o".$occuranceCount;
    		} else {
    			$occurrenceText ="";
    		}   		
 
    		// Get attributes
    		$rsAttributes = $category->getAttributes();
    		foreach ($rsAttributes as $attribute) {
    			$keyName = "^A-".$attribute->name."(".$category->letter.")".$occurrenceText."^";
    			$displayName = $attribute->name."(".$category->letter.")".$occurrenceText;
    		
    			$attributes[] = array("key" => $keyName, "value" => $displayName);	
    		}		
    	}
    	   
    	return($attributes);
    }
    
	/**
     * Returns a Rowset of rule_semantic_action records for the current rule record
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getRuleSemanticActions() {
        $select = $this->select()->order(array('id'));
        return($this->findDependentRowset('Application_Model_DbTable_RuleSemanticActions', 'Rules', $select));
    }

    public function __toString() {
        $categories = array();
        $transform = $this->getRuleTransform();
        foreach ($transform as $child_rule) {
            $categories[] = $child_rule->getCategory()->letter;
        }
        return (implode(' ', $categories));
    }
}

?>