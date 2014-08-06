<?php

class Application_Model_DbTable_Row_Grammar extends Zend_Db_Table_Row_Abstract
{

    /**
     * Returns true if the grammar.user_id is equal to the currently authenticated 
     * user or it is a public grammar
     * 
     * @return boolean
     */
    public function isAccessible() {
        return ($this->user_id == 0 || $this->user_id == Genocad_Application::getUserId());
    }
    
    /**
     * Returns true if the grammar.user_id is equal to the currently authenticated user.
     * 
     * @return boolean
     */
    public function isEditable() {
        return ($this->user_id != 0 && $this->user_id == Genocad_Application::getUserId());
    }
    
    /** 
     * Convert grammar converts an non-attribute grammar to an attribute grammar, or vice versa
     * 
     * @return grammar_id
     */

    public function convert() {
    	if ($this->isAttributeGrammar()) {
    		// convert changes it back to regular grammar
    		
    		// delete rule_semantic_actions
    		foreach($this->getRules() as $rule) {
                foreach ($rule->getRuleSemanticActions() as $action) {
                			$action->delete();
                }
            }	
            
    		foreach($this->getCategories() as $category) {
                foreach ($category->getAttributes() as $categoryAttribute) {
        			foreach ($categoryAttribute->getAttributeLists() as $categoryAttributeList) {
        				$categoryAttributeList->delete();
        			}
        			$categoryAttribute->delete();
                }
            }
            
    		foreach($this->getAttributeGrammars() as $attributeGrammar) {
                $attributeGrammar->delete();
            }
                	
            foreach($this->getCodeTbgenerated() as $code) {
            	$code->delete();
            }
    		
    	} else {
    		// convert changes it to an attribute grammar
    		$dbAttributeGrammars = new Application_Model_DbTable_AttributeGrammars();
    		$data = array();
    		$data["grammar_id"] = $this->grammar_id;
            $row = $dbAttributeGrammars->createRow($data);
            $row->save();
            
           // Need to consider how we are going to handle the modeling category -- it needs a special part sequence that can be deleted, but it has to be unique for 
           // validation ...
           
           $dbCategories = new Application_Model_DbTable_Categories();
           if (!($dbCategories->getCategoryByLetterAndGrammar('MDL', $row->grammar_id))) {
		   		$model_category_data = array( 
					'letter' => 'MDL',
		    		'description' => 'Model/Initial Conditions',
		   			'description_text' => "Special case category for storing modeling parameters and initial conditions as parts' attributes in an attribute grammar.  Associated parts do not have sequences.",
					'icon_name' => 'icon_mdl.png',
					'grammar_id' => $row->grammar_id
				);
		
        		$category = $dbCategories->addCategory($model_category_data);
           }	
    	}
    }

    /**
     * Returns true of the given grammar record is able to be deleted.
     * 
     * @return boolean
     */
    public function isDeletable() {

        if ($this->isEditable()) {
        	return (true);
        } else {
            return (false);
        }

    }

    public function getRules() {
        return($this->findDependentRowset('Application_Model_DbTable_Rules'));
    }
    
    public function getCategories() {
        return($this->findDependentRowset('Application_Model_DbTable_Categories'));
    }

    public function getStartingCategory() {
        return($this->findParentRow('Application_Model_DbTable_Categories', 'StartingCategory'));
    }
    
    public function getCategoryList() {
        $rsCategories = $this->getCategories();
        foreach ($rsCategories as $category) {
            $categories[] = array("key"=> $category->category_id, "value"=> $category->getLabel());
        }
        return ($categories);
    }
    
   // public function getAttributeList () {
   // 	$rsCategories = $this->getCategories();
   // 	foreach ($rsCategories as $category) {
   // 		$rsAttributes = $category->getAttributes();
   // 		foreach ($rsAttributes as $attribute) {
   // 			$attributes[] = array("key" => $attribute->id, "value" => $attribute->name . " (" . $category->letter . ")");
   // 		}
   // 	}
   // 	return ($attributes);
    	
    //}
    
	public function getLibraries() {
        return($this->findDependentRowset('Application_Model_DbTable_Libraries'));
    }
    
    public function hasLibraries() {
    	return(count($this->getLibraries()));
    }
    
	public function getCodeTbgenerated() {
		$depTable = new Application_Model_DbTable_CodeTbgenerated();
        return($this->findDependentRowset($depTable, null, $depTable->select()->order('id asc')));
    }
    
	public function getAttributeGrammars() {
        return($this->findDependentRowset('Application_Model_DbTable_AttributeGrammars'));
    }

    /**
     * Returns a rowset of libraries records that are accessible by the user that
     * is currently authenticated.  If the user has not been authenticated, then
     * this will only return public libraries
     * 
     * @return Zend_Db_Table_Rowset
     */
    public function getUserLibraries() {
        if (Genocad_Application::isLoggedIn()) {
            $select = $this->select()->where('user_id = 0 or user_id = ?', Genocad_Application::getUser()->user_id);
        } else {
            $select = $this->select()->where('user_id = 0');
        }
        return($this->findDependentRowset('Application_Model_DbTable_Libraries', 'Grammars', $select));
    }
    
    /*
     * This function returns a key/value array that contains a listing of 
     * user libraries for the given grammar
     */
    public function getUserLibraryList($user_id) {

        $rsLibraries = $this->getLibraries();
        $libraries = Array();

        foreach ($rsLibraries as $library) {
            if ($library->user_id == $user_id) {
                $libraries[] = array("key"=> $library->library_id, "value"=> $library->name);
            }
        }

        return ($libraries);
    }

	/*
     * This function returns a key/value array that contains a listing of 
     * user libraries for the given grammar
     */
    public function getUsersLibraryList() {

        $rsLibraries = $this->getUserLibraries();
        $libraries = Array();

        foreach ($rsLibraries as $library) {
            $libraries[] = array("key"=> $library->library_id, "value"=> $library->name);
        }

        return ($libraries);
    }
    
    /*
     * This function returns a key/value array that contains a listing of 
     * user and public libraries for the given grammar
     */
    public function getUserandPublicLibraryList($user_id) {

        $rsLibraries = $this->getLibraries();

        foreach ($rsLibraries as $library) {
            if ($library->user_id == $user_id || $library->user_id == '0') {
                $libraries[] = array("key"=> $library->library_id, "value"=> $library->name);
            }
        }

        return ($libraries);
    }

    /**
     * Returns true if the given grammar is an Attribute Grammar
     * 
     * @return boolean
     */
    public function isAttributeGrammar() {
        return (count($this->findDependentRowset('Application_Model_DbTable_AttributeGrammars')) > 0);
    }

    /**
     * Returns the base url for the image set images associated with the grammar
     * 
     * @return String
     */
    public function getImageUrl() {
        return (Application_Model_ImageSets::getImageSetUrl($this->icon_set));
    }

    /**
     * Returns the base url for the icon images for the image set associated with the grammar
     * 
     * @return String
     */
    public function getIconUrl() {
        return (Application_Model_ImageSets::getImageSetIconUrl($this->icon_set));
    }

    public function export($data) {

    	if ($this->isAttributeGrammar()) {
        	$isAttribute = true;
        } else {
        	$isAttribute = false;
        }
        
        $xml = new SimpleXMLElement("<grammar></grammar>");
        
        foreach ($this->toArray() as $key => $value) {
            if ($this->getTable()->isIdentity($key)) {
                $xml->addAttribute($key, $value);
            }
            $xml->addChild($key, $value);  
        }
        
    	if ($isAttribute) {
        	$xml->addAttribute("isAttributeGrammar", "true");
        } else {
        	$xml->addAttribute("isAttributeGrammar", "false");	
        }
                
        // Add Categories
        $xml->addChild('categories');
        
        foreach ($this->getCategories() as $key => $category) {
            $xml->categories->addChild('category');
            Genocad_Utilities_RowToXML::append($category, $xml->categories->category[$key]);
        
           	$category_xml = $xml->categories->category[$key];
           	$category_xml->addChild('attributes');
           	foreach ($category->getAttributes() as $keya => $categoryAttribute) {
           		$category_xml->attributes->addChild('attribute');
           		Genocad_Utilities_RowToXML::append($categoryAttribute, $category_xml->attributes->attribute[$keya]);
           		// get category attribute list assigns
           		$category_attribute_xml = $category_xml->attributes->attribute[$keya];
           		$category_attribute_xml->addChild('lists');
           		foreach ($categoryAttribute->getAttributeLists() as $keyl => $attributeList) {
           			$category_attribute_xml->addChild('list');
           			Genocad_Utilities_RowToXML::append($attributeList, $category_attribute_xml->lists->list[$keyl]);
           		}
           	}
        }

        // Add Rules
        $xml->addChild('rules');
        
        foreach ($this->getRules() as $key => $rule) {

            // Add Rule
            $xml->rules->addChild('rule');
            Genocad_Utilities_RowToXML::append($rule, $xml->rules->rule[$key]);
            $rule_xml = $xml->rules->rule[$key];
            
            // Add Rule Transform
            $transform = array();
            foreach ($rule->getRuleTransform() as $rule_transform) {
                $transform[] = $rule_transform->category_id;
            }
            
           // add the rule transformation
           	$rule_xml->addChild('transform', implode(',', $transform));

           	// Add Rule Semantic Actions
           	$rule_xml->addChild('semantic_actions');
           	foreach ($rule->getRuleSemanticActions() as $rsa_key => $rsa) {
               	$rule_xml->semantic_actions->addChild('rule_semantic_action');
               	Genocad_Utilities_RowToXML::append($rsa, $rule_xml->semantic_actions->rule_semantic_action[$rsa_key]);
           	}    
           
        }
        
        // Add attribute grammars
        $xml->addChild('attribute_grammars');
        foreach ($this->getAttributeGrammars() as $ag_key => $attributeGrammar) {
        	$xml->attribute_grammars->addChild('attribute_grammar');
        	Genocad_Utilities_RowToXML::append($attributeGrammar, $xml->attribute_grammars->attribute_grammar[$ag_key]);
        }

        $xml->addChild('code_tbgenerateds');
        // Add Code To-Be Generated
        foreach ($this->getCodeTbgenerated() as $key => $code) {
           	$xml->code_tbgenerateds->addChild('code_tbgenerated');
           	Genocad_Utilities_RowToXML::append($code, $xml->code_tbgenerateds->code_tbgenerated[$key]);
        }
        
       	// This next section assumes that the user included some libraries when they decided to do the 
       	// export.  Including libraries by default includes parts and designs.
       	if (array_key_exists('include_libraries', $data)) {
        	$libraries = $data['include_libraries'];
        
        	// add libraries node
        	$xmllibraries = $xml->addChild('libraries');
        	$dbLibraries = new Application_Model_DbTable_Libraries();
        	$dbParts = new Application_Model_DbTable_Parts();
        	$partsArray = Array();
        	$designsArray = Array();
        	
        	foreach($libraries as $library) {
        		$dbLibrary = $dbLibraries->find($library)->current();
        		$xmllibrary = $xmllibraries->addChild('library');
        		foreach($dbLibrary->toArray() as $key => $lib) {
        			if ($dbLibrary->getTable()->isIdentity($key)) {
                		$xmllibrary->addAttribute($key, $lib);
            		}
            		$xmllibrary->addChild($key, $lib);  
        		}
        		
        		if ($dbLibrary->hasParts()) {
        			// add parts to the parts array
        			$parts = $dbLibrary->getParts();
        			
        			foreach ($parts as $part) {
        				if (!(array_key_exists($part->part_id, $partsArray))) {
        					$newPart = $dbParts->find($part->part_id)->current();
        					$partsArray[$part->part_id] = $newPart; 
        				}
        			}	
        		}
        		
        		foreach ($dbLibrary->getDesigns() as $design) {
        			$designArray[$design->design_id] = $design;
        		}
        	}
   			
        	// below libraries, add the parts
        	$xmlparts = $xml->addChild('parts');
        	foreach($partsArray as $key => $part2) {
        		$xmlPart = $xmlparts->addChild('part');
        		Genocad_Utilities_RowToXML::append($part2, $xmlPart);
				
        		// add categories
        		$xmlPartsCats = $xmlPart->addChild('categories');
        		
        		foreach($part2->getCategories() as $cat) {
        			$xmlPartsCats->addChild('category', $cat->category_id);
        		}
        		
        		// now add libraries
        		$xmlPartLibs = $xmlPart->addChild('libraries');
        		
        		foreach ($part2->getLibraries() as $lib) {
        			if (array_search($lib->library_id, $libraries) !== FALSE) {
        				$xmlPartLib = $xmlPartLibs->addChild('library', $lib->library_id);
        			}	
        		}
        	}
        	
        	// parts_attributes
        	$xmlPartsAttributes = $xml->addChild('parts_attributes');
        	if ($isAttribute) {
        		foreach ($partsArray as $key => $part) {
        			foreach ($part->getAttributes() as $attrib_key => $attrib) {
        				$xmlPartAttrib = $xmlPartsAttributes->addChild('part_attribute');
        				Genocad_Utilities_RowToXML::append($attrib, $xmlPartAttrib);
        			}
        		}
        	}
        	
        	// designs
        	$xmlDesigns = $xml->addChild('designs');
        	
        	foreach($designArray as $key => $design) {
        		if (($design->user_id == 0) || ($design->user_id == (int)Genocad_Application::getUserId())) {
        			$xmlDesign = $xmlDesigns->addChild('design');
        			Genocad_Utilities_RowToXML::append($design, $xmlDesign);
        		
        			$xmlSteps = $xmlDesign->addChild('design_steps');
        			foreach ($design->getDesignSteps() as $step_key => $designStep) {
        				$xmlStep =  $xmlSteps->addChild('design_step');
        				Genocad_Utilities_RowToXML::append($designStep, $xmlStep);
        			
        				$xmlStepParts = $xmlStep->addChild('design_step_parts');
        				foreach($designStep->getDesignStepParts() as $part_key => $designStepPart) {
        					$xmlStepPart = $xmlStepParts->addChild('design_step_part');
        					Genocad_Utilities_RowToXML::append($designStepPart, $xmlStepPart);
        				}
        			}	
        		}
        	}
        }
        
        return ($xml->asXml());
        
    }

    public function import($xml) {
        
        
    }

    public function getJsTreeNode() {
        $node = array();
    
        $node["attr"]["id"] = $this->grammar_id;
        $node["state"] = "open";
        $node["attr"]["rel"] = "root";
        $node["data"]["title"] = $this->name;
        $node["data"]["icon"] = new Zend_Json_Expr('"/images/propeller.png"');
        $node["data"]["attr"]["id"] = $this->grammar_id;
        $node["data"]["attr"]["style"] = "cursor: default; font-weight: bold";

        return ($node);
    }
    
}

?>