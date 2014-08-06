<?php
class Genocad_Utilities_Grammar_AttributeGrammar
{

    protected $_path;
    protected $_zip;
    protected $_grammarXMLFile;
    protected $_grammar;
    protected $_errors = array();

    public function copyAttributes($grammar_id_source, $grammar_id_destination) {
    	$dbGrammars = new Application_Model_DbTable_Grammars();
    	$dbAttributeGrammars = new Application_Model_DbTable_AttributeGrammars();
    	$dbCategories = new Application_Model_DbTable_Categories();
    	$dbCategoriesAttributes = new Application_Model_DbTable_CategoriesAttributes();
    	
    	$grammar_from = $dbGrammars->find($grammar_id_source)->current();
    	$grammar_to = $dbGrammars->find($grammar_id_destination)->current();
    	$attribute_grammar_from = $dbAttributeGrammars->find($grammar_id_source)->current();
    	
    	
    	
    	
    }
    public function process($icon_choice, $iconset_name) {
    
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammars->importGrammar($this->getGrammarXML());

        if (($this->iconSetExists() && $icon_choice == 2) || !$this->iconSetExists()) {
            Application_Model_ImageSets::createFromZip($this->_path, $iconset_name);
            $grammar->icon_set = $iconset_name;
            $grammar->save();
        }
        
        return ($grammar);
    }

}