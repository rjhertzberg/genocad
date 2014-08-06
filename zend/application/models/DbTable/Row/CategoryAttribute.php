<?php

class Application_Model_DbTable_Row_CategoryAttribute extends Zend_Db_Table_Row_Abstract
{
	
	public function getAttributeLists() {
        return($this->findDependentRowset('Application_Model_DbTable_CategoryAttributeLists'));
    }
    
    public function getListAssignsCategoryList() {
    	$lists = $this->getAttributeLists();
    	$categories = Array();
    	foreach ($lists as $list) {
    		$categories[] = $list->category_id;
    	}

    	return ($categories);
    }

    /**
     * Returns a Zend_Form_Element, which is either a input text item or a
     * select list depending on the attribute_type_id
     * 
     * @param Integer $part_id
     * @returns Zend_Form_Element
     */
    public function getFormItem($part_id) {

        // gets the value for the given Attribute and Part 
        $values = $this->getPartValues($part_id);

        // if this is a single value attribute type, then create the Text form element
        if (($this->attribute_type_id == 0) || ($this->attribute_type_id == 3)) {
            $item = new Zend_Form_Element_Text((string) $this->id);
            $item->setAttrib('class','part-attribute');
            $item->setValue($values[0]->value);
            
        // otherwise, this is a list form element which requires a multi-select
        // list of parts based on the attribute categories
        } elseif ($this->attribute_type_id == 1) {

            // create the multi-select list and set the HTML attributes
            $item = new Zend_Form_Element_Multiselect((string)$this->id);
            $item->setAttrib('size','10');
            $item->setAttrib('class','parts-list');
            
            // retrieve the category parts
            $categories = $this->getParts();
            
            // loop through the category parts and add them to the select options
            $parts_list = Array();
            foreach ($categories as $category) {
                foreach ($category as $part) {
                    $parts_list[$part->id] = $part->part_id . ' - ' . $part->description;
                }
                $item->setMultiOptions($parts_list);
            }

            // set the selected options based on the existing attribute values
            $value = Array();
            foreach ($values as $part_value) {
                $value[] = $part_value->value;
            }

            $item->setValue($value);
        } else {
        	// this is a mapping value -- will need to provide add, edit, and delete buttons at minimum
        	// create the select list and set the HTML attributes
        	$item = new Zend_Form_Element_Select((string)$this->id);
        	$item->setAttrib('size', '5');
        	// come back and figure out what the below does
        	$item->setAttrib('class', 'mapping-list');
        	
        	// For now, just make a list of the parts_attributes_assigns
        	$mapArray = Array();
        	$dbParts = new Application_Model_DbTable_Parts(); 
        	foreach ($values as $value) {
        		$tempString = substr(trim($value->value), 1, strlen(trim($value->value)) - 2);
                $valueArray = explode(",", $tempString);
                $part = $dbParts->getPart(trim($valueArray[0]));
                $mapArray[$value->id] = $part->part_id . " - " . $part->description. "( Value: ". $valueArray[1].")";
        	}
        	$item->setMultiOptions($mapArray);
        	
        }

        // create the Zend_Form_Element and return it
        $item -> setLabel($this->name)
              -> setBelongsTo('attribute')
              -> setDecorators(
                    array(
                        'ViewHelper',
                        'Errors',
                        array(array('data' => 'HtmlTag'), array('tag' => 'td', 'class' => 'element')),
                        array('Label', array('tag' => 'td', 'optionalSuffix'=>':', 'requiredSuffix' => ':')),
                        array(array('row' => 'HtmlTag'), array('tag' => 'tr', 'valign' => 'top')),
                ));

        return ($item);

    }
    
    /**
     * Returns a Rowset of related parts_category_attributes records for the given
     * part_id
     * 
     * @param Integer $part_id
     * @return Zend_Db_Table_Rowset
     */
    public function getPartValues($part_id) {
        $select = $this->select()->where('part_id = ?', $part_id);
        return($this->findDependentRowset('Application_Model_DbTable_PartsCategoryAttributes', 'CategoryAttributes', $select));
    }
    

    /**
     * Returns a Rowset of Parts for the Attributes that reference a list of Categories
     * that are used as potential values for the attribute (List of Values).
     * 
     * @return array
     */
    public function getParts() {

        $lists = $this->findDependentRowset('Application_Model_DbTable_CategoryAttributeLists');
        $categories = Array();
        foreach ($lists as $list) {
            $category = $list->findParentRow('Application_Model_DbTable_Categories');
            $categories[] = $category->getParts();
        }

        return ($categories);

    }
    
	public function edit ($category_id, $name, $description, $display_order, $categoriesListAssigns) {

		$dbAttributesListAssigns = new Application_Model_DbTable_CategoryAttributeLists();
		
		$oldAttributeType = $this->attribute_type_id;
		
        $data = array (
        	'id' => $this->id,
            'category_id' => $category_id,
            'name' => $name,
        	'description' => $description,
        	'display_order' => $display_order
        );

        $this->setFromArray($data);
        $this->save();
        
        if ($oldAttributeType > 0) {
        	// remove old list assigns
        	$childLists = $this->getAttributeLists();
        	foreach ($childLists as $childList) {
        		$childList->delete();
        	}
        	
        	// don't save categories for attribute_type numeric
        	foreach ($categoriesListAssigns as $category_id) {
        		$dbAttributesListAssigns->addCategory($this->id, $category_id);
        	}
        	// need to find some way to reconcile the parts_category_attribute_assigns
        	//$dbPartsAttributes = new Application_Model_DbTable_PartsCategoryAttributes();
        	//$dbPartsAttributes->removeOrphans($this->id);
        } //else {
        	// need to delete child attribute lists and parts list assigns if the attribute_type_id has changed from list to numeric
        	//if ($oldAttributeType > 0) {
        	//	$childLists = $this->getAttributeLists();
        	//	foreach ($childLists as $childList) {
        	//		$childList->delete();
        	//	}

        	//	$partLists = $this->findDependentRowset('Application_Model_DbTable_PartsCategoryAttributes');
        	//	foreach($partLists as $partList) {
        	//		$partList->delete();
        	//	}
        	//}
        //}	

        return ($row);
    }

}