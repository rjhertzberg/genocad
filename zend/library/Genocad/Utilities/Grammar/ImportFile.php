<?php
class Genocad_Utilities_Grammar_ImportFile
{

    protected $_path;
    protected $_zip;
    protected $_grammarXMLFile;
    protected $_grammar;
    protected $_errors = array();

    public function __construct($path = null) {

        if ($path == null) {
            $this->_path = $_SESSION["grammar_import_file"];
        } else {
            $this->_path = $path;
            $_SESSION["grammar_import_file"] = $path;
        }

        // open the zip file and process the grammar.xml file
        $this->_zip = new ZipArchive();
    }

    public function open() {
        return($this->_zip->open($this->_path));
    }

    public function close() {
        $this->_zip->close();
    }
    
    public function validate() {
        
        $this->_errors = array();
        
        $open = $this->open();

        if ($open === TRUE) {

            // check for the grammar.xml file
            if (!$this->_zip->getStream("grammar.xml")) {
                $this->_errors[] = "The grammar.xml file does not exist in the import zip file";
            }

        } else {
            $this->_errors[] = "The file is not a valid ZipArchive: " . $open;
        }

        if (count($this->_errors) > 0) {
            return false;
        }
        
        return true;

    }

    public function getGrammarXML() {
        $this->open();
        $this->_grammarXMLFile = $this->_zip->getStream("grammar.xml");
        $this->_grammar = simplexml_load_string(stream_get_contents($this->_grammarXMLFile));
        return($this->_grammar);
    }

    public function getErrors() {
        return ($this->_errors);
    }
    
    public function iconSetExists() {
        return(Application_Model_ImageSets::exists((string)$this->getGrammarXML()->icon_set));
    }

    public function process($icon_choice, $iconset_name) {
    
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $grammar = $dbGrammars->importGrammar($this->getGrammarXML());

        //if (($this->iconSetExists() && $icon_choice == 2) || !$this->iconSetExists()) {
            Application_Model_ImageSets::createFromZip($this->_path, $iconset_name);
            $grammar->icon_set = $iconset_name;
            $grammar->save();
        //}
        
        return ($grammar);
    }

}