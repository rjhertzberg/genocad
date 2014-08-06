<?php

class Design_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        $this->view->headTitle("GenoCAD: A Wizard to Design Genetic Constructs");

    }

    public function indexAction()
    {
        $this->view->headScript()->appendFile('/js/design.js');
        $this->view->headScript()->appendFile('/js/tiptip/jquery.tipTip.js');
        $this->view->headLink()->appendStylesheet('/js/tiptip/tipTip.css');
        $this->view->headScript()->appendFile('/js/json2.js');

        $dbGrammars = new Application_Model_DbTable_Grammars();
        $this->view->grammars = $dbGrammars->getLibraryGrammars();

        $form = new Design_Form_Design();

        $dbDesigns = new Application_Model_DbTable_Designs();
        $design_id = $this->_request->getParam('design_id');

        if ($design = $dbDesigns->find($design_id)->current()) {
            if (Genocad_Application::getUserId() == $design->user_id || $design->isPublicDesign()) {
                $design->validate();
                $this->view->design = $design;
                $form->getElement('design_id')->setValue($design->design_id);
                $form->getElement('design_library_id')->setValue($design->library_id);
                $form->getElement('design_is_public')->setValue($design->isPublicDesign() ? '1' : '0');
                $form->getElement('design_name')->setValue($design->name);
                $form->getElement('design_description')->setValue($design->description);
                $library = $design->getLibrary();
    
                $this->view->library = $library;
                $this->view->grammar_id = $library->grammar_id;
            }
        }

        $this->view->design_form = $form;
    }

    public function publicDesignsAction()
    {
        $dbDesigns = new Application_Model_DbTable_Designs();
        $this->view->designs = $dbDesigns->getPublicDesigns();
    }


    public function saveAction()
    {
        $dbDesigns = new Application_Model_DbTable_Designs();
        $design_id = $this->getRequest()->getParam('design_id');
        $design = $dbDesigns->find($design_id)->current();

        $steps = $design->getDesignSteps();
        $steps_arr = Array();

        foreach ($steps as $step) {

            $parts_arr = Array();

            $parts = $step->getDesignStepParts();

            foreach ($parts as $part) {
                $parts_arr[] = array('category_index' => $part->category_index, 'category_id' => $part->category_id, 'part_id'=> $part->part_id);
            }

            $steps_arr[] = $parts_arr;
        }

        $this->view->history = $steps_arr;

    }

    public function myDesignsAction()
    {
        //$auth = Zend_Auth::getInstance();
        //if (!$auth->hasIdentity()) {
        //    $this->_helper->redirector('index', 'login', 'default');
       // }

    	$this->view->headScript()->appendFile('/js/tiptip/jquery.tipTip.js');
        $this->view->headLink()->appendStylesheet('/js/tiptip/tipTip.css');
        $this->view->headScript()->appendFile('/js/dataTables-1.7/media/js/jquery.dataTables.js');
        $this->view->headScript()->appendFile('/js/dataTables.fnReloadAjax.js');
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_page.css');
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_table_jui.css');

        $dbDesigns = new Application_Model_DbTable_Designs();
        $this->view->designs = $dbDesigns->getUserDesigns();
        $this->view->publicDesigns = $dbDesigns->getPublicDesigns();
    }

    public function mapVectorAction() 
    {
    	// populate local variables based on request parameters
    	$requestTerminals = $this->getRequest()->getParam('terminals');
    	$designName =  $this->getRequest()->getParam('designName');
        $designDesc =  $this->getRequest()->getParam('designDesc');
        $designId =  $this->getRequest()->getParam('design_id');
        $libraryId =  $this->getRequest()->getParam('library_id');
        $grammarId =  $this->getRequest()->getParam('grammar_id');
        $requestCategories = $this->getRequest()->getParam('categories');
        
        $genBankString = Genocad_Utilities_Designs_ReverseComplement::genbankExport ($designName, $designDesc, $designId, $libraryId, $grammarId, $requestCategories, $requestTerminals);
        $filename = 'my_genbank_design_'.rand().'.txt';
        $dirname = Zend_Registry::get('config')->design->genbank_root;
        $urlname = Zend_Registry::get('config')->design->genbank_url;
                
        // Write the genBankString to a file
        $genBank = fopen($dirname.$filename, 'w') or die ("Cannot open the genbank file");
        fwrite($genBank, $genBankString);
        fclose($genBank);
        
        // Somehow pass the filename back to the javascript
        $this->view->filename = "happy";//$urlname."/".$filename;            
    }
    
    public function downloadSequenceAction()
    {

        // populate local variables based on request parameters
        $format = $this->getRequest()->getParam('format');
        
        // regardless of the format, this process needs to get the sequence of the design
        $sequence = "";
        $terminals = explode("|", $this->getRequest()->getParam('terminals'));
        $dbParts = new Application_Model_DbTable_Parts();
        $parts = Array();
        $partIndex = 0;
        $partIndexString = "";

        foreach ($terminals as $terminal) {
            $part = $dbParts->find($terminal)->current();
            $parts[] = $part;
            if (($part->segment == '[') || ($part->segment == ']')) {
            	$tempVal = $part->segment;
            } else {
            	$tempVal = $partIndex;	
            } 
            if ($partIndex > 0) {
            	$partIndexString .= "|".$tempVal;
            } else {
            	$partIndexString .= $tempVal;	
            }
            $partIndex++;
            $sequence .= strtolower($part->segment);
        }
        
        $partIndexArray = explode("|", Genocad_Utilities_Designs_ReverseComplement::reverse_parts_genbank($partIndexString));

        $sequence = strtolower(Genocad_Utilities_Designs_ReverseComplement::sequence_reverse($sequence));
        
        
        if ($format == 'genbank') {

            $filename = 'my_genbank_design.txt';

            $designName =  $this->getRequest()->getParam('designName');
            $designDesc =  $this->getRequest()->getParam('designDesc');
            $designId =  $this->getRequest()->getParam('design_id');
            $libraryId =  $this->getRequest()->getParam('library_id');
            $grammarId =  $this->getRequest()->getParam('grammar_id');
            
            // need to get the categories from the database to check 
            // the genbank qualifiers
            $dbCategories = new Application_Model_DbTable_Categories();
            $categories = Array();         
            foreach (explode("|",$this->getRequest()->getParam('categories')) as $category) {
                $categories[] = $dbCategories->find($category)->current();
            }

            $staticElementArray = Array();
            
            // get intregal bits from the database
            if ($designId != NULL){
                $dbDesigns = new Application_Model_DbTable_Designs();
                $design = $dbDesigns->find($designId)->current();

                $staticElementArray["mod_date"] = date("d-M-Y", strtotime($design->last_modification));
                $staticElementArray["design_name"] = $design->name;
                $staticElementArray["definition"] = trim($design->name).'.';
                $staticElementArray["comment"] = $design->description;

            } else {

                $staticElementArray["mod_date"] = date("d-M-Y");
                $staticElementArray["design_name"] = " ";
                $staticElementArray["definition"] = ".";
                $staticElementArray["comment"] = "";
            }
            
            // requery sequenceArray because the name is undefined above
            // second pass to remove the () and {}
        	$sequenceArray = Genocad_Utilities_Designs_ReverseComplement::sequence_divide($staticElementArray["design_name"], strtolower($sequence));
        	$tempSequence = explode('|',$sequenceArray[0]);
        	$sequence = $tempSequence[2];

            $db = Zend_Db::factory(Zend_Registry::get('config')->resources->db);

            $total_base_pairs = strlen($sequence);
            $staticElementArray["total_base_pairs"] = $total_base_pairs;

            $genbankFileString = "";
            $lastLineNumber = 1;

            $dbGenbankSpecs = new Application_Model_DbTable_GenbankSpecs();
            $select = $dbGenbankSpecs->select()
                                     ->where('line_number < 8')
                                     ->order(array('line_number', 'start_position'));

            $specs = $dbGenbankSpecs->fetchAll($select);

            foreach ($specs as $spec) {

                // writing out non-repeatables
                if ($spec->line_number > $lastLineNumber) {
                    // time to change lines
                    $genbankFileString .=  PHP_EOL;
                    $lastLineNumber = $spec->line_number;
                }

                $length = 1 + ($spec->end_position - $spec->start_position);
        
                // if the value field is not null, then we write that value; otherwise, we get the value from staticElementArray
                $linebreak = 0;

                if ($spec->value != NULL){
                    if ($spec->value == "(blank)")
                        $writeValue = " ";
                    else 
                        $writeValue = $spec->value;                 
                } else {
                    if ($spec->field_name == "comment") {
                        $linebreak = 1;
                    }
                    $writeValue = $staticElementArray[$spec->field_name];
                }
        
                // TODO: will eventually need to handle scenario where the length of the definition is longer than the 
                // total field, but for now just make sure you don't exceed the length allotted on a single line
                if ($linebreak == 0){
                    if ($spec->justification == "L") {
                        $genbankFileString .= str_pad(substr(trim($writeValue), 0, $length), $length, " ", STR_PAD_RIGHT); 
                    } else {
                        $genbankFileString .= str_pad(substr(trim($writeValue), 0, $length), $length, " ", STR_PAD_LEFT);
                    }
                } else {
                    // a linebreak line needs to be indented to the 13th position and end with a period.
                    // The first time through, will have the title -- after that, need to preface with blanks
                    // also do not want line break to occur in the middle of a word.

                    $writeValue = trim(str_replace(PHP_EOL, " ", $writeValue));

                    $writeValueLength = strlen($writeValue);
                    if (substr($writeValue, $writeValueLength - 1, 1) != '.') {
                        $writeValue .= '.';
                        $writeValueLength += 1;
                    } 

                    $posStart = 0;

                    while ($posStart < $writeValueLength) {

                        // get position of last space in the substring between $posStart and $posEnd
                        if (($posStart + 67) >= $writeValueLength) {
                            $posEnd = 67;
                        } else {
                            $posEnd = strripos(substr($writeValue, $posStart, 67), ' ');
                            if (!$posEnd) {
                                $posEnd = 67;
                            }
                        }   

                        $genbankFileString .= substr($writeValue, $posStart, $posEnd);

                        $posStart += $posEnd;

                        while (($posStart < $writeValueLength) && (substr($writeValue, $posStart, 1) == ' ')) {
                            $posStart += 1;
                        }

                        if ($posStart < $writeValueLength) {
                            // more to write
                            $genbankFileString .= PHP_EOL.str_pad(' ', 12, ' ', STR_PAD_RIGHT);
                        }
                    }
                }
            }
            $genbankFileString .= PHP_EOL;

            // features
            // When you get to line numbers 7 and 8, those can be repeated (and 8 can be repeated under 7, though I don't anticipate
            // doing that.

            // start with source -- covers the entire design
            // 1-5 -- blanks
            $genbankFileString .= str_pad(' ', 5, ' ', STR_PAD_RIGHT);
            // 6-20 -- category key -- left-justified
            $genbankFileString .= str_pad('source', 15, ' ', STR_PAD_RIGHT);
            // 21 -- space
            $genbankFileString .= ' ';
            // 22-80 base pairs clause -- gets more detailed, but for now just start..stop
            $genbankFileString .= "1..".$total_base_pairs.PHP_EOL;

            if (count($parts) == count($categories)) {

                // see if there are more features we can use
                $baseCounter = 0;
                $dbGenbankQualifers = new Application_Model_DbTable_GenbankQualifiers();
                
                // Add plasmids and chromosomes -- need to adjust so that they come in source order, but will
                // handle that later
                $featuresArray = array();
                foreach ($sequenceArray as $tempSequence) {
                	$lines = explode("|", $tempSequence);
                	if ($lines[1] != "design") {
                		$tempLine = "";
                		
                		$cpStart = $lines[1] + 1;
                		$cpEnd = strlen($lines[2]) + $lines[1];
                		if (!(($cpStart == 1) AND ($cpEnd == $total_base_pairs))) {
                			// 1-5 blanks
                			$tempLine .= str_pad(' ', 5, ' ', STR_PAD_RIGHT);
                			// 6-20 source -- left-justified
                			$tempLine .=  str_pad('source', 15, ' ', STR_PAD_RIGHT);
                			// 21 space
                			$tempLine .= ' ';
                			// 22-80 base pairs clause
                			$tempLine .= $cpStart."..".$cpEnd.PHP_EOL;
                		}	
                		
                		// next line, 21 blanks
                		$tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                		
                		$cpName = $lines[0];
                		// check to see if chromosome or plasmid
                		$tempPos = strrpos($lines[0], '_');
                		if (substr($lines[0], $tempPos+1, 1) == 'p') {
                			// plasmid
                			$tempLine .= '/plasmid="'.$cpName.'"'.PHP_EOL;
                		} else {
                			$tempLine .= '/chromosome="'.$cpName.'"'.PHP_EOL;
                		}
                		
                		while (array_key_exists($cpStart, $featuresArray)) {
                			$cpStart += 1;
                		}
                		$featuresArray[$cpStart] = $tempLine; 
                		
                	}
                }

               	$revComp = false;
                for ($j = 0; $j < count($partIndexArray); $j++) {
                	$i = $partIndexArray[$j];

                	if (is_numeric($i)) {
                    // we need to check the segment length if only for the baseCounter
                    $part = $parts[$i];
                    $partLength = strlen(trim(str_replace(array("{","}","[","]","(",")"), "", $part->segment)));
                    $category = $categories[$i];
                    $tempLine = "";

                    // check to see if the part in question's category has a qualifier
                    if ($category->genbank_qualifier_id != '') {

                        // get the genbank qualifier from the database
                        $qualifier = $dbGenbankQualifers->find($category->genbank_qualifier_id)->current();

                        // 1-5 blanks
                        $tempLine .= str_pad(' ', 5, ' ', STR_PAD_RIGHT);
                        
                        // 6-20 -- category key -- left-justified
                        $tempLine .= str_pad(trim(substr($qualifier->qualifier, 0, 15)), 15, ' ', STR_PAD_RIGHT);
                        
                        // 21 -- space
                        $tempLine .= ' ';
                        
                        // 22-80 base pairs clause -- gets more detailed, but for now just start..stop
                        $baseStart = $baseCounter + 1;
                        $baseEnd = $baseCounter + $partLength;
                        if ($revComp) {
                        	$tempLine .= "complement(".$baseStart."..".$baseEnd.")".PHP_EOL;
                        } else {
                        	$tempLine .= $baseStart."..".$baseEnd.PHP_EOL;
                        }
                                                
                        // Add additional qualifier info
                        // label
                        $tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                        $tempLine .= '/label="'.substr($part->description, 0, 50).'"'.PHP_EOL;
                        $tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                        $tempLine .= '/note="GenoCAD Category: '.$category->description.'"'.PHP_EOL;
                        if (strlen(trim($part->description_text)) > 0){
                            $tempLine .= str_pad(' ', 21, ' ', STR_PAD_RIGHT);
                            
                            $tempLine .= '/note="'.substr($part->description_text, 0, 50).'"'.PHP_EOL;
                        }
                        
                        $cpStart = $baseStart;
                        while (array_key_exists($cpStart, $featuresArray)) {
                			$cpStart += 1;
                		}
                		$featuresArray[$cpStart] = $tempLine;                           
                    }
                    $baseCounter += $partLength;
                	} else {
                		// i is not numeric -- means reverse complement indicator
                		$revComp = !($revComp); 
                	}
                } 
                
                // write the featuresArray
                ksort($featuresArray);
                foreach($featuresArray as $feature){
                	$genbankFileString .= $feature;
                }
            }

            // Now add origins line
            $genbankFileString .= "ORIGIN".PHP_EOL;

            // Now add sequence
            $lineNumber = 1;

            while ($lineNumber <= $total_base_pairs) {
                $genbankFileString .= str_pad($lineNumber, 9, ' ', STR_PAD_LEFT).' ';
    
                $tempString = str_pad(substr($sequence, $lineNumber - 1, 60), 60, ' ', STR_PAD_RIGHT);
    
                $genbankFileString .= chunk_split($tempString, 10, " ") . PHP_EOL;

                $lineNumber += 60;                                    
            }

            $genbankFileString .= "//";

            $this->view->sequence = $genbankFileString;


        } else {
        	// second pass to remove the () and {}
        	$sequenceArray = Genocad_Utilities_Designs_ReverseComplement::sequence_divide(" ", strtolower($sequence));
        	$tempSequence = explode('|',$sequenceArray[0]);
        	$sequence = $tempSequence[2];

            $filename = 'sequence.txt';

            $this->view->sequence = $sequence;
            
        }

        $this->_helper->layout()->disableLayout();
        $this->getResponse()
             ->setHeader('Content-Disposition', 'attachment; filename=' . $filename)
             ->setHeader('Content-type', 'application/octet-stream');

    }

    public function copyAction()
    {
        $dbDesigns = new Application_Model_DbTable_Designs();
        $design_id = $this->getRequest()->getParam('design_id');
        $dbDesigns->cloneDesign($design_id);
        $this->_helper->redirector('my-designs');
    }

    public function exportAction()
    {

        $export_type = $this->getRequest()->getParam('type');
        if ($export_type == "tab") {
            $filename = 'my_designs_tab_delim.txt';
        }
        else if ($export_type == "fasta") {
             $filename = 'my_designs_fasta.fasta';
        }

        $this->_helper->layout()->disableLayout();
        $this->getResponse()
             ->setHeader('Content-Disposition', 'attachment; filename='. $filename)
             ->setHeader('Content-type', 'application/octet-stream');

        $dbDesigns = new Application_Model_DbTable_Designs();
        $designs = $dbDesigns->find($this->getRequest()->getParam('design_id'));
        foreach ($designs as $design) {
            $this->view->export .= $design->getExport($export_type);
        }

    }

}


