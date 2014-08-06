<?php

class Application_Model_DbTable_Grammars extends Zend_Db_Table_Abstract
{

    protected $_name = 'grammars';
    protected $_primary = 'grammar_id';
    protected $_dependentTables = array('Application_Model_DbTable_Categories', 
                                        'Application_Model_DbTable_Libraries', 
                                        'Application_Model_DbTable_Rules', 
    	                                'Application_Model_DbTable_AttributeGrammars',
                                        'Application_Model_DbTable_CodeTbgenerated'
                                        );

    protected $_referenceMap    = array(
        'StartingCategory' => array(
            'columns'           => 'starting_category_id',
            'refTableClass'     => 'Application_Model_DbTable_Categories',
            'refColumns'        => 'category_id'
        )
    );

    protected $_rowClass = 'Application_Model_DbTable_Row_Grammar';

    public function getGrammarList() {

        $select  = $this->select()->from ($this->_name, array('key' => 'grammar_id', 'value' => 'name'));
        $select->where("user_id in (?,?)", array("0", Genocad_Application::getUserId()));
        $result = $this->getAdapter()->fetchAll($select);
        return $result;

    }

    public function getPublicGrammars() {

        $select  = $this->select()->where('user_id = 0');
        return($this->fetchAll($select));

    }

    public function getUserGrammars() {

        $select  = $this->select()->where('user_id = ?', Genocad_Application::getUserId());
        return($this->fetchAll($select));

    }

    /**
     * This function will return only grammar rows that the user has access to, and 
     * that has parts associated with it.
     * 
     * @return Zend_DbTable_Rowset
     */
    public function getMyPartsGrammars() {

        $select  = $this->select()->where('grammar_id in (select grammar_id from v_parts_browser v where part_user_id = ?)', (int) Genocad_Application::getUserId());
        $result = $this->fetchAll($select);
        return $result;

    }

    /**
     * This function will return only grammar rows that the user has access to, and 
     * that have a library associated with it.
     * 
     * @return Zend_DbTable_Rowset
     */
    public function getLibraryGrammars() {

        $select  = $this->select()->where("grammar_id in (select grammar_id from libraries where user_id in (0, ?))", (int) Genocad_Application::getUserId());
        return($this->fetchAll($select));

    }
    public function addGrammar($data) {

        $data['user_id'] = Genocad_Application::getUserId();

        $row = $this->createRow($data);
        $row->save();
        
        // create a default starting category
        $category_data = array(
            'letter' => 'S',
            'description' => 'Start / Transcription unit',
            'icon_name' => 'icon_s.png',
            'grammar_id' => $row->grammar_id
        );
        
        // create the categories for reverse complement, plasmid, and chromosome delimiters
		$rc_open_category_data = array( 
			'letter' => '[',
		    'description' => 'Opening reverse complement delimiter',
			'icon_name' => 'icon_[.png',
			'grammar_id' => $row->grammar_id
		);
		
		$rc_close_category_data = array( 
			'letter' => ']',
		    'description' => 'Closing reverse complement delimiter',
			'icon_name' => 'icon_].png',
			'grammar_id' => $row->grammar_id
		);
		
		$plasmid_open_category_data = array( 
			'letter' => '(',
		    'description' => 'Opening plasmid delimiter',
			'icon_name' => 'icon_(.png',
			'grammar_id' => $row->grammar_id
		);
		
		$plasmid_close_category_data = array( 
			'letter' => ')',
		    'description' => 'Closing plasmid delimiter',
			'icon_name' => 'icon_).png',
			'grammar_id' => $row->grammar_id
		);
		
		$chromosome_open_category_data = array( 
			'letter' => '{',
		    'description' => 'Opening chromosome delimiter',
			'icon_name' => 'icon_{.png',
			'grammar_id' => $row->grammar_id
		);
		
		$chromosome_close_category_data = array( 
			'letter' => '}',
		    'description' => 'Closing chromosome delimiter',
			'icon_name' => 'icon_}.png',
			'grammar_id' => $row->grammar_id
		);
		
        $dbCategories = new Application_Model_DbTable_Categories();
        $category = $dbCategories->addCategory($category_data);
 
        // Add other categories
        $temp_category = $dbCategories->addCategory($rc_open_category_data);
        $temp_category = $dbCategories->addCategory($rc_close_category_data); 
		$temp_category = $dbCategories->addCategory($plasmid_open_category_data);
		$temp_category = $dbCategories->addCategory($plasmid_close_category_data);
		$temp_category = $dbCategories->addCategory($chromosome_open_category_data);
		$temp_category = $dbCategories->addCategory($chromosome_close_category_data);
        
		$row->starting_category_id = $category->category_id;
        $row->save();
        return($row);

    }

    public function deleteGrammar($id) {

        $grammar = $this->find($id)->current();
        $isAttribute = $grammar->isAttributeGrammar();
        
        if ($grammar) {
        	// first delete dependencies -- designs, parts and libraries
        	foreach ($grammar->getLibraries() as $library) {
        		// get designs
        		foreach($library->getDesigns() as $design) {
        			$design->delete();
        		}
        		
        		//delete library -- library_parts will be deleted automatically, and parts will be deleted with categories_parts
        		$library->delete();
        	}
        	
            if ($grammar->isDeletable()) {
                // first delete the rules
                foreach($grammar->getRules() as $rule) {
                	if ($isAttribute) {
                		foreach ($rule->getRuleSemanticActions() as $action) {
                			$action->delete();
                		}
                	}	
                    $rule->delete();
                }
                
                foreach($grammar->getCategories() as $category) {
                	foreach($category->getParts() as $part) {
                		$part->delete();
                	}
                	if ($isAttribute) {
                		foreach ($category->getAttributes() as $categoryAttribute) {
        					foreach ($categoryAttribute->getAttributeLists() as $categoryAttributeList) {
        						$categoryAttributeList->delete();
        					}
        					$categoryAttribute->delete();
                		}
                	}	
                	$category->delete();	
                }
                
                if ($isAttribute) {
                	foreach($grammar->getAttributeGrammars() as $attributeGrammar) {
                		$attributeGrammar->delete();
                	}
                	
                	foreach($grammar->getCodeTbgenerated() as $code) {
                		$code->delete();
                	}
                }
                return($grammar->delete());
            }
        } else {
            return (0);
        }

    }

    /**
     * 
     * @param int $id
     * @param array $data
     */
    public function copyGrammar($id, $data) {

        $dbCategories = new Application_Model_DbTable_Categories();
        $dbCategoryAttributes = new Application_Model_DbTable_CategoryAttributes();
        $dbCategoryAttributeLists = new Application_Model_DbTable_CategoryAttributeLists();
        $dbRules = new Application_Model_DbTable_Rules();
        $dbCodeTbgenerated = new Application_Model_DbTable_CodeTbgenerated();
        $dbRuleSemanticActions = new Application_Model_DbTable_RuleSemanticActions();
        $dbAttributeGrammars = new Application_Model_DbTable_AttributeGrammars();
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $dbParts = new Application_Model_DbTable_Parts();
        $dbCategoryParts = new Application_Model_DbTable_CategoryParts();
        $dbLibraryParts = new Application_Model_DbTable_LibraryParts();
        $dbPartsCategoryAttributes = new Application_Model_DbTable_PartsCategoryAttributes();
        $dbDesigns = new Application_Model_DbTable_Designs();
        $dbDesignSteps = new Application_Model_DbTable_DesignSteps();
        $dbDesignStepParts = new Application_Model_DbTable_DesignStepParts();
        
        // first, get the original grammar based on the passed id
        $oldGrammar = $this->find($id)->current();
        $starting_category_id = $data['starting_category_id'];
        $user_id = Genocad_Application::getUserId();
        if (array_key_exists('include_libraries', $data)) {
        	$libraries = $data['include_libraries'];
        	unset($data['include_libraries']);
        } else {
        	$libraries = array();
        }

        // next, create the new grammar based on the $data parameter
        $data['user_id'] = $user_id;
        unset($data['grammar_id']);
        unset($data['starting_category_id']);
        $newGrammar = $this->createRow($data);
        $newGrammar->save();
        
        // add attribute grammar rows (if any)
        if ($oldGrammar->isAttributeGrammar()) {
    		foreach ($oldGrammar->getAttributeGrammars() as $attributeGrammar) {
            	$data = $attributeGrammar->toArray();
            	$data["grammar_id"] = $newGrammar->grammar_id;
            	$row = $dbAttributeGrammars->createRow($data);
            	$row->save();
        	}
        
        	foreach ($oldGrammar->getCodeTbgenerated() as $code) {
            	$data = $code->toArray();
            	$data["grammar_id"] = $newGrammar->grammar_id;
            	unset($data["id"]);
            	$row = $dbCodeTbgenerated->createRow($data);
            	$row->save();
        	}	
        	
        	$isAttribute = true;
        } else {
        	$isAttribute = false;
        } 	

        $mapCategory = array();
        $mapAttribute = array();
        $mapLibrary = array();
        $mapPart = array();

        foreach ($oldGrammar->getCategories() as $category) {
            $mapCategory[$category->category_id]["old"] = $category;
            
            $newCategory = $category->toArray();
            unset($newCategory["category_id"]);
            $newCategory["grammar_id"] = $newGrammar->grammar_id;
            $mapCategory[$category->category_id]["new"] = $dbCategories->addCategory($newCategory);
            
            // now try to get the category_attributes
            if ($isAttribute) {
        		foreach ($category->getAttributes() as $categoryAttribute) {
        			$mapAttribute[$categoryAttribute->id]["old"] = $categoryAttribute;
            		$data = $categoryAttribute->toArray();
            		$data["category_id"] = $mapCategory[$category->category_id]["new"]->category_id;
            		unset($data["id"]);
            		$row = $dbCategoryAttributes->createRow($data);
            		$row->save();
            		$mapAttribute[$categoryAttribute->id]["new"] = $row;
        		}
            }	
        }
        
        if ($isAttribute) {
        	// need to get the category_attribute_list_assigns -- not possible before because we might not have had all the categories in mapCategory
        	// if we get this working, should try to do with mapAttribute only
        	foreach ($oldGrammar->getCategories() as $category) {
        		foreach ($category->getAttributes() as $categoryAttribute) {
        			foreach ($categoryAttribute->getAttributeLists() as $categoryAttributeList) {
        				$data = $categoryAttributeList->toArray();
        				$data["category_attribute_id"] = $mapAttribute[$categoryAttribute->id]["new"]->id;
        				$data["category_id"] = $mapCategory[$data["category_id"]]["new"]->category_id;
        				unset($data["id"]);
        				$row = $dbCategoryAttributeLists->createRow($data);
        				$row->save();
        			}
        		}
        	} 
        }
        
        foreach ($oldGrammar->getRules() as $rule) {
            $arrTransform = array();
            foreach($rule->getRuleTransform() as $transform) {
                $arrTransform[] = $mapCategory[$transform->category_id]["new"]["category_id"];
            }

            $newRule = $dbRules->add($rule->code, $mapCategory[$rule->category_id]["new"]["category_id"] ,$newGrammar->grammar_id,$arrTransform);
            
            if ($isAttribute) {
            	foreach ($rule->getRuleSemanticActions() as $action) {
                	$data = $action->toArray();
                	$data["rule_id"] = $newRule->rule_id;
                	unset($data["id"]);
                	
                	// We need to convert the old action to point to categories and attributes from the new grammar.
                	// Attributes are indicated by the letter A followed by the attribute id, and categories by Name followed by the category_id.  Are they always followed by spaces? 
                	$action = $data["action"];
                	$position = 0;
                	$tempAction = "";
                	// Convert attributes first
                	do {
                		$tempPosition = strpos($action, 'A', $position);
                		$oldAttributeId = "";
                		if (!($tempPosition === false)) {
                			// parse the string to get the full number
                			$tempPosition = $tempPosition + 1;
                			
                			if ($tempPosition < strlen($action)) {
                				$tempAction .= substr($action, $position, $tempPosition - $position);

                				while (($tempPosition < strlen($action)) && (is_numeric(substr($action, $tempPosition, 1)))) {
                					$oldAttributeId .= substr($action, $tempPosition, 1);
                					$tempPosition += 1;
                				}
                				if ((strlen(trim($oldAttributeId)) > 0) && array_key_exists((int)$oldAttributeId, $mapAttribute)) {
                					$tempAction .= trim($mapAttribute[trim($oldAttributeId)]["new"]->id);
                				} else {
                					$tempAction .= trim($oldAttributeId);
                				}
                				$position = $tempPosition;
                			}
                		}
                	} while (!($tempPosition === false) && ($tempPosition < strlen($action)));
                	// get the end of the action
                	if ($position < strlen($action)) {
                		$tempAction .= substr($action, $position, strlen($action) - $position);
                	}
                	
                	// okay, set $action to $tempAction and start over with Name for category
					$action = $tempAction;
					$tempAction = "";
					$position = 0;
					
                	do {
                		$tempPosition = strpos($action, 'Name', $position);
                		$oldCategoryId = "";
                		if (!($tempPosition === false)) {
                			// parse the string to get the full number
                			$tempPosition = $tempPosition + 4;
                			
                			if ($tempPosition < strlen($action)) {
                				$tempAction .= substr($action, $position, $tempPosition - $position);

                				while (($tempPosition < strlen($action)) && (is_numeric(substr($action, $tempPosition, 1)))) {
                					$oldCategoryId .= substr($action, $tempPosition, 1);
                					$tempPosition += 1;
                				}
                				if ((strlen(trim($oldCategoryId)) > 0) && (array_key_exists((int)$oldCategoryId, $mapCategory))) {
                					$tempAction .= trim($mapCategory[trim($oldCategoryId)]["new"]->category_id);
                				} else {
                					$tempAction .= trim($oldCategoryId);
                				}	
                				$position = $tempPosition;
                			}
                		}
                	} while ((!($tempPosition === false)) && ($tempPosition < strlen($action)));
                	
                	// get the end of the action
                	if ($position < strlen($action)) {
                		$tempAction .= substr($action, $position, strlen($action) - $position);
                	}
                	
            	// okay, set $action to $tempAction and start over with Name for category
					$action = $tempAction;
					$tempAction = "";
					$position = 0;
					
                	do {
                		$tempPosition = strpos($action, 'C', $position);
                		$oldCategoryId = "";
                		if (!($tempPosition === false)) {
                			// parse the string to get the full number
                			$tempPosition = $tempPosition + 1;
                			
                			if ($tempPosition < strlen($action)) {
                				$tempAction .= substr($action, $position, $tempPosition - $position);

                				while (($tempPosition < strlen($action)) && (is_numeric(substr($action, $tempPosition, 1)))) {
                					$oldCategoryId .= substr($action, $tempPosition, 1);
                					$tempPosition += 1;
                				}
                				if ((strlen(trim($oldCategoryId)) > 0) && (array_key_exists((int)$oldCategoryId, $mapCategory))) {
                					$tempAction .= trim($mapCategory[(int)trim($oldCategoryId)]["new"]->category_id);
                				} else {
                					$tempAction .= trim($oldCategoryId);
                				}	
                				$position = $tempPosition;
                			}
                		}
                	} while ((!($tempPosition === false)) && ($tempPosition < strlen($action)));
                	
                	// get the end of the action
                	if ($position < strlen($action)) {
                		$tempAction .= substr($action, $position, strlen($action) - $position);
                	}
                	
                	$data["action"] = $tempAction;
                	$row = $dbRuleSemanticActions->createRow($data);
                	$row->save();
            	}
            }	            
        }
        
        $newGrammar->starting_category_id = $mapCategory[$starting_category_id]["new"]["category_id"];
        $newGrammar->save();
        
        $oldPartsArray = array();
        
        foreach($libraries as $library_id) {
        	// create a replacement for each library and map to the old library
        	$library = $dbLibraries->find($library_id)->current();
        	          
            $newLibraryId = $dbLibraries->addLibrary ($newGrammar->grammar_id, $library->name, $library->description, $user_id, false);
            
            // delete newly added special case parts -- they aren't properly mapped, would lose any attributes or semantic actions
            //$tempLibrary = $dbLibraries->find($newLibraryId)->current();
            //$tempLibraryParts = $tempLibrary->getParts();
            //foreach($tempLibraryParts as $tempLibraryPart) {
			//	$part_id = $tempLibraryPart->part_id;            	
            //	$tempLibraryPart->delete();
            	
            //	$tempPart = $dbParts->find($part_id)->current();
            //	$tempPart->delete();
            //}

            $parts = $library->getParts();
            foreach ($parts as $libPart) {
            	$part = $dbParts->find($libPart->part_id)->current();
            	if (($part->user_id == 0) || ($part->user_id == $user_id)) {
            		if (array_key_exists($part->id, $mapPart)) {
            			// already been mapped, now map to new library
            			$dbLibraryParts->addPart($newLibraryId, $mapPart[$part->id]["new"]->id);
            		} else {
            			$oldPartsArray[] = $part->id; 
            			$mapPart[$part->id]["old"] = $part;
            		            		
            			// get categories from categories_parts for old part, then make an array of new categories to assign to part mapping
            			$newCategoriesParts = array();
            		
            			foreach($part->getCategories() as $cat) {
            				$newCategoriesParts[] = $mapCategory[$cat->category_id]["new"]->category_id;
            			}
            		
            			// Will pick up other libraries as we go through the list
            			$newLibrary = array("library_id" => $newLibraryId);
            		
            			$mapPart[$part->id]["new"] = $dbParts->add ($part->description, $part->segment, $part->description_text, $newLibrary, $newCategoriesParts);
            		}
            	}
            }
            
            // Now that the parts have been remapped, we can get the designs
            $designs = $library->getDesigns();
            foreach($designs as $design) {
            	// create the new design and get the new design id
            	if (($design->user_id == 0) || ($design->user_id == $user_id)) {
            		$data = $design->toArray();
            		$data["library_id"] = $newLibraryId;
            		$data["user_id"] = $user_id;
            		unset($data["design_id"]);
            		$newDesign = $dbDesigns->createRow($data);
            		$newDesign->save();
            	
            		//get all the design_steps and reinsert them with the new design id
            		$designSteps = $design->getDesignSteps();
            		foreach ($designSteps as $designStep) {
            			$data = $designStep->toArray();
            			$data["design_id"] = $newDesign->design_id;
            			unset($data["step_id"]);
            			$newDesignStep = $dbDesignSteps->createRow($data);
            			$newDesignStep->save();
            		
            			//get all of the design_step_parts and reinsert them with new design_step_id, category_id, and part_id
            			$designStepParts = $designStep->getDesignStepParts();
            			foreach ($designStepParts as $designStepPart) {
            				$data = $designStepPart->toArray();
            				$data["step_id"] = $newDesignStep->step_id;
            				$data["category_id"] = $mapCategory[$designStepPart->category_id]["new"]->category_id;
            				if ($data["part_id"] != null) {
            					$data["part_id"] = $mapPart[$designStepPart->part_id]["new"]->id;
            				}
            				$newDesignStepPart = $dbDesignStepParts->createRow($data);
            				$newDesignStepPart->save();
            			}
            		}
            	}	
            }
        }
        
        // Now do the complete list for parts_category_attribute_assign
        if ($isAttribute) {
        	foreach ($oldPartsArray as $old_part_id) {
        		$part = $dbParts->find($old_part_id)->current();
        		
        		// adding the part automatically adds blank parts attributes, so make sure we delete those first.
       			$dbPartsCategoryAttributes->clear($mapPart[$part->id]["new"]->id);
       			
        		foreach($part->getAttributes() as $partAttribute) {
        			$new_part_id = $mapPart[$part->id]["new"]->id;
        			$new_attribute_id = $mapAttribute[$partAttribute->category_attribute_id]["new"]->id;
        			        		
        			// see if the value needs to be converted
        			if ($mapAttribute[$partAttribute->category_attribute_id]["new"]->attribute_type_id == 1) {
        				$new_attribute_value = $mapPart[$partAttribute->value]["new"]->id;
        			} elseif ($mapAttribute[$partAttribute->category_attribute_id]["new"]->attribute_type_id == 2) {
        				// truly yucky -- have to extract the part_id and the value from the field
        				$tempString = substr(trim($partAttribute->value), 1, strlen(trim($partAttribute->value)) - 2);
                		$valueArray = explode(",", $tempString);
                		$new_attribute_value = "[".$mapPart[$valueArray[0]]["new"]->id.",".$valueArray[1]."]";
        			} else {
        				$new_attribute_value = $partAttribute->value;
        			}
        			$dbPartsCategoryAttributes->add($new_part_id, $new_attribute_id, $new_attribute_value);
        		}
        	}
        }	
        
        
        return ($newGrammar);

    }

    public function importGrammar($xml) {

        $dbCategories = new Application_Model_DbTable_Categories();
        $dbRules = new Application_Model_DbTable_Rules();
        $dbCodeTbgenerated = new Application_Model_DbTable_CodeTbgenerated();
        $dbRuleSemanticActions = new Application_Model_DbTable_RuleSemanticActions();
        $dbCategoryAttributes = new Application_Model_DbTable_CategoryAttributes();
        $dbCategoryAttributeLists = new Application_Model_DbTable_CategoryAttributeLists();
        $dbAttributeGrammars = new Application_Model_DbTable_AttributeGrammars();
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $dbParts = new Application_Model_DbTable_Parts();
        $dbDesigns = new Application_Model_DbTable_Designs();
        $dbDesignSteps = new Application_Model_DbTable_DesignSteps();
        $dbDesignStepParts = new Application_Model_DbTable_DesignStepParts();
        $dbPartsCategoryAttributes = new Application_Model_DbTable_PartsCategoryAttributes();

        // next, create the new grammar based on the $data parameter
        foreach($xml->children() as $child) {
            $data[$child->getName()] = $child;
        }

        $user_id = Genocad_Application::getUserId();
        $data['user_id'] = $user_id;
        unset($data['grammar_id']);
        $grammar = $this->createRow($data);
        $grammar->save();

        $mapCategory = array();
        $mapAttribute = array();
        $mapPart = array();
        $mapLibrary = array();

        foreach ($xml->categories->children() as $category) {
            $newCategory = array(
                "letter" => $category->letter,
                "description" => $category->description,
           	    "description_text" => $category->description_text,
                "grammar_id" => $grammar->grammar_id,
                "icon_name" => $category->icon_name
            );
            if ((int)$category->genbank_qualifier_id != 0) {
                $newCategory["genbank_qualifier_id"] = (int)$category->genbank_qualifier_id;
            }
            $mapCategory[(int)$category->category_id] = $dbCategories->addCategory($newCategory);
        }
        
        foreach ($xml->categories->children() as $category) {
        	foreach ($category->attributes->children() as $attribute) {
        		$newAttribute = array(
        			"category_id" => $mapCategory[(int)$attribute->category_id]->category_id,
        			"name" => $attribute->name,
        			"description" => $attribute->description,
        			"display_order" => $attribute->display_order,
        			"attribute_type_id" => $attribute->attribute_type_id);
        		$row = $dbCategoryAttributes->createRow($newAttribute);
        		$row->save();
        		$mapAttribute[(int)$attribute->id] = $row;
        		foreach ($attribute->lists->children() as $list) {
        			$newList = array(
        				"category_attribute_id" => $mapAttribute[(int)$list->category_attribute_id]->id,
        				"category_id" => $mapCategory[(int)$list->category_id]->category_id);
        			$rowl = $dbCategoryAttributeLists->createRow($newList);
        			$rowl->save();
        		}
        	}
        }
        
        $grammar->starting_category_id = $mapCategory[(int)$xml->starting_category_id]["category_id"];
        $grammar->save();

        foreach ($xml->rules->children() as $rule) {

            $arrTransform = array();
            
            if ($rule->transform != "") {
                foreach(explode(',', $rule->transform) as $transform) {
                    $arrTransform[] = $mapCategory[(int)$transform]["category_id"];
                }
            }

            $newRule = $dbRules->add( $rule->code, $mapCategory[(int)$rule->category_id]["category_id"] ,$grammar->grammar_id, $arrTransform);

            foreach ($rule->semantic_actions->children() as $action) {
                $data = array();
                $data["rule_id"] = $newRule->rule_id;
                
                // Need to convert all of the old category and attribute ids to new ones.
                // We need to convert the old action to point to categories and attributes from the new grammar.
                // Attributes are indicated by the letter A followed by the attribute id, and categories by Name followed by the category_id.
                // Also, "C" followed by category_id  
                $action = $action->action;
                $position = 0;
                $tempAction = "";
                // Convert attributes first
                do {
                	$tempPosition = strpos($action, 'A', $position);
                	$oldAttributeId = "";
                	if (!($tempPosition === false)) {
                		// parse the string to get the full number
                		$tempPosition = $tempPosition + 1;
                			
                		if ($tempPosition < strlen($action)) {
                			$tempAction .= substr($action, $position, $tempPosition - $position);

                			while (($tempPosition < strlen($action)) && (is_numeric(substr($action, $tempPosition, 1)))) {
                				$oldAttributeId .= substr($action, $tempPosition, 1);
                				$tempPosition += 1;
                			}
                			if ((strlen(trim($oldAttributeId)) > 0) && array_key_exists((int)$oldAttributeId, $mapAttribute)) {
                				$tempAction .= trim($mapAttribute[trim($oldAttributeId)]->id);
                			} else {
                				$tempAction .= trim($oldAttributeId);
                			}
                			$position = $tempPosition;
                		}
                	}
                } while (!($tempPosition === false) && ($tempPosition < strlen($action)));
                // get the end of the action
                if ($position < strlen($action)) {
                	$tempAction .= substr($action, $position, strlen($action) - $position);
                }
                	
                // okay, set $action to $tempAction and start over with Name for category
				$action = $tempAction;
				$tempAction = "";
				$position = 0;
					
                do {
                	$tempPosition = strpos($action, 'Name', $position);
                	$oldCategoryId = "";
                	if (!($tempPosition === false)) {
                		// parse the string to get the full number
                		$tempPosition = $tempPosition + 4;
                			
                		if ($tempPosition < strlen($action)) {
                			$tempAction .= substr($action, $position, $tempPosition - $position);

                			while (($tempPosition < strlen($action)) && (is_numeric(substr($action, $tempPosition, 1)))) {
                				$oldCategoryId .= substr($action, $tempPosition, 1);
                				$tempPosition += 1;
                			}
                			if ((strlen(trim($oldCategoryId)) > 0) && (array_key_exists((int)$oldCategoryId, $mapCategory))) {
                				$tempAction .= trim($mapCategory[trim($oldCategoryId)]->category_id);
                			} else {
                				$tempAction .= trim($oldCategoryId);
                			}	
                			$position = $tempPosition;
                		}
                	}
                } while ((!($tempPosition === false)) && ($tempPosition < strlen($action)));
                	
                // get the end of the action
                if ($position < strlen($action)) {
                	$tempAction .= substr($action, $position, strlen($action) - $position);
                }
                
            // okay, set $action to $tempAction and start over with C for category
				$action = $tempAction;
				$tempAction = "";
				$position = 0;
					
                do {
                	$tempPosition = strpos($action, 'C', $position);
                	$oldCategoryId = "";
                	if (!($tempPosition === false)) {
                		// parse the string to get the full number
                		$tempPosition = $tempPosition + 1;
                			
                		if ($tempPosition < strlen($action)) {
                			$tempAction .= substr($action, $position, $tempPosition - $position);

                			while (($tempPosition < strlen($action)) && (is_numeric(substr($action, $tempPosition, 1)))) {
                				$oldCategoryId .= substr($action, $tempPosition, 1);
                				$tempPosition += 1;
                			}
                			if ((strlen(trim($oldCategoryId)) > 0) && (array_key_exists((int)$oldCategoryId, $mapCategory))) {
                				$tempAction .= trim($mapCategory[trim($oldCategoryId)]->category_id);
                			} else {
                				$tempAction .= trim($oldCategoryId);
                			}	
                			$position = $tempPosition;
                		}
                	}
                } while ((!($tempPosition === false)) && ($tempPosition < strlen($action)));
                	
                // get the end of the action
                if ($position < strlen($action)) {
                	$tempAction .= substr($action, $position, strlen($action) - $position);
                }
                	
                $data["action"] = $tempAction;
                
                $row = $dbRuleSemanticActions->createRow($data);
                $row->save();
            }

        }
    
        foreach ($xml->attribute_grammars->children() as $attributeGrammar) {
        	$data = array();
        	$data["grammar_id"] = $grammar->grammar_id;
        	$data["code_init"] = $attributeGrammar->code_init;
        	$data["code_end"] = $attributeGrammar->code_end;
        	$row = $dbAttributeGrammars->createRow($data);
        	$row->save();
        }
        
        foreach ($xml->code_tbgenerateds->children() as $code) {
            $data = array();
            $data["grammar_id"] = $grammar->grammar_id;
            $data["type"] = $code->type;
            $data["code"] = $code->code;
            $row = $dbCodeTbgenerated->createRow($data);
            $row->save();
        }
        
        foreach ($xml->libraries->children() as $library) {
        	$newLibraryId = $dbLibraries->addLibrary ($grammar->grammar_id, $library->name, $library->description, $user_id, false);
            
            // delete newly added special case parts -- they aren't properly mapped, would lose any attributes or semantic actions
        	$tempLibrary = $dbLibraries->find($newLibraryId)->current();
            //$tempLibraryParts = $tempLibrary->getParts();
            //foreach($tempLibraryParts as $tempLibraryPart) {
			//	$part_id = $tempLibraryPart->part_id;            	
            //	$tempLibraryPart->delete();
            	
            //	$tempPart = $dbParts->find($part_id)->current();
            //	$tempPart->delete();
            //}
            
            // add to mapLibrary so we can appropriately map the designs and parts later
            $mapLibrary[(int)$library->library_id] = $tempLibrary;
        }
        
        foreach ($xml->parts->children() as $part) {
        	// make list of libraries for part add
        	$newLibrary = array();
        	$newCategory = array();
        	foreach ($part->libraries->children() as $partLib) {
        		$newLibrary[] = $mapLibrary[(int)$partLib]->library_id;
        	}
        	
        	foreach ($part->categories->children() as $partCat) {
        		$newCategory[] = $mapCategory[(int)$partCat]->category_id;
        	}
        	
        	$mapPart[(int)$part->id] = $dbParts->add ($part->description, $part->segment, $part->description_text, $newLibrary, $newCategory);
        }
        
        foreach ($xml->designs->children() as $design) {
        	$data = array();
        	$data["library_id"] = $mapLibrary[(int)$design->library_id]->library_id;
        	$data["user_id"] = $user_id;
        	$data["name"] = $design->name;
        	$data["description"] = $design->description;
        	$data["last_modification"] = $design->last_modification;
        	$data["is_public"] = (int)$design->is_public;
        	$data["sequence"] = $design->sequence;
        	$data["is_validated"] = (int)$design->is_validated;
        	$newDesign = $dbDesigns->createRow($data);
        	$newDesign->save();
        	
        	foreach($design->design_steps->children() as $design_step) {
        		$data2 = array();
        		$data2["step_index"] = (int)$design_step->step_index;
        		$data2["design_id"] = $newDesign->design_id;
        		$newDesignStep = $dbDesignSteps->createRow($data2);
        		$newDesignStep->save();
        		
        		foreach ($design_step->design_step_parts->children() as $design_step_part) {
        			$data3= array();
        			$data3["category_index"] = (int)$design_step_part->category_index;
        			$data3["step_id"] = $newDesignStep->step_id;
        			        			
        			if ($design_step_part->category_id != null) {
        				$data3["category_id"] = $mapCategory[(int)$design_step_part->category_id]->category_id;
        			}
        			
        			if (!(empty($design_step_part->part_id))) {
                    	$data3["part_id"] = $mapPart[(int)$design_step_part->part_id]->id;
                    } else {
                    	$data["part_id"] = null;
                    }
        			
					$newDesignStepPart = $dbDesignStepParts->createRow($data3);
					$newDesignStepPart->save();
        		}	
        	}
        }
        
    	// adding the part automatically adds blank parts attributes, so first clear out the newly created $dbPartsCategoryAttributes.
        foreach($mapPart as $part) {
       		$dbPartsCategoryAttributes->clear($part->id);
        }
        
        foreach ($xml->parts_attributes->children() as $partAttrib) {
                $new_part_id = $mapPart[(int)$partAttrib->part_id]->id;
                $new_attribute_id = $mapAttribute[(int)$partAttrib->category_attribute_id]->id;

                // see if the value needs to be converted
                if ($mapAttribute[(int)$partAttrib->category_attribute_id]->attribute_type_id == 1) {
                        $new_attribute_value = $mapPart[(int)$partAttrib->value]->id;
                } elseif ($mapAttribute[(int)$partAttrib->category_attribute_id]->attribute_type_id == 2) {
                        // truly yucky -- have to extract the part_id and the value from the field
                        $tempString = substr(trim($partAttrib->value), 1, strlen(trim($partAttrib->value)) - 2);
                        $valueArray = explode(",", $tempString);
                        $new_attribute_value = "[".$mapPart[$valueArray[0]]->id.",".$valueArray[1]."]";
                } else {
                        $new_attribute_value = $partAttrib->value;
                }
                $dbPartsCategoryAttributes->add($new_part_id, $new_attribute_id, $new_attribute_value);
        }
        
        return ($grammar);

    }

    /**
     * 
     * 
     * @param Grammar_Form_Grammar $form
     */
    public function saveGrammarForm(Grammar_Form_Grammar $form, $code_init, $code_end, $code_tbgenerated) {

        $grammar_id = $form->getValue('grammar_id');

        // if the grammar_id is null, then it's a new row
        if ($grammar_id == '') {
            $data = array (
                'name' => $form->getValue('name'),
                'description' => $form->getValue('description'),
                'icon_set' => $form->getValue('icon_set')
            );

            $row = $this->addGrammar($data);

        } else {
            // retrieve the design record for the given design_id
            $row = $this->find($grammar_id)->current();

            // set the proper values for the design record
            $row->name = $form->getValue('name');
            $row->description = $form->getValue('description');
            $row->starting_category_id = (int) $form->getValue('starting_category_id');
            $row->icon_set = $form->getValue('icon_set');

            $row->save();
            
            if ($row->isAttributeGrammar()) {
            	// need to save the code_init and code_end
            	$dbAttributeGrammars = new Application_Model_DbTable_AttributeGrammars();
            	
            	$attrow = $dbAttributeGrammars->find($grammar_id)->current();
            	$attrow->code_init = $code_init;
            	$attrow->code_end = $code_end;
            	$attrow->save();
            	
            	// clean out the code_tbgenerateds
            	$dbCodeTbgenerated = new Application_Model_DbTable_CodeTbgenerated();
        		$dbCodeTbgenerated->clearCodeTbgenerated($grammar_id);

            	// readd the code_tbgenerated from the screen.
            	// This is a little weird -- each of the fields (name and code) count as separate rows, so we need 
            	// to catch the first and store, then add row when we get the second value
            	$count = 1;
            	$name = "";
            	foreach($code_tbgenerated as $caption => $value) {
            		if ($count%2 == 1) {
            			$name = $value;
            		} else {
            			$dbCodeTbgenerated->add($grammar_id, $name, $value);
            		}
            		$count++;	
            	}
            }
            
        }

        // set the design_id variable to the value of the PK for the row
        $grammar_id = $row->grammar_id;
        
        return ($row);

    }

    
}
?>

