<?php

class Parts_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        $this->view->headTitle("GenoCAD: Repository of Biological Parts");
        $this->view->headScript()->appendFile('/js/jstree/jquery.jstree.js');
        $this->view->headScript()->appendFile('/js/dataTables-1.7/media/js/jquery.dataTables.js');
        $this->view->headScript()->appendFile('/js/dataTables.fnReloadAjax.js');
        $this->view->headScript()->appendFile('/js/parts_browser.js');
        $this->view->headScript()->appendFile('/js/tiptip/jquery.tipTip.js');
        $this->view->headScript()->appendFile('/js/jquery.multiselect2side.js');

        $this->view->headScript()->appendFile('/js/multiselect/jquery.multiselect.min.js');
        
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_page.css');
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_table_jui.css');
        $this->view->headLink()->appendStylesheet('/js/tiptip/tipTip.css');
        $this->view->headLink()->appendStylesheet('/js/jquery.multiselect2side.css');
        $this->view->headLink()->appendStylesheet('/js/multiselect/jquery.multiselect.css');

    }

    public function indexAction()
    {

        $this->view->headScript()->appendFile('/js/selectmenu/jquery.ui.selectmenu.js');
        $this->view->headLink()->appendStylesheet('/js/selectmenu/jquery.ui.selectmenu.css');
        
        // action body
        $dbGrammars = new Application_Model_DbTable_Grammars();
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $grammars = $dbGrammars->fetchAll();
        $myLibraries = $dbLibraries->getUserLibraries();
        $myLibraryGrammarIds = array();
        
        foreach ($myLibraries as $library) {
            $myLibraryGrammarIds[] = $library->grammar_id;
        }
        
        $myLibraryGrammars = $dbGrammars->find($myLibraryGrammarIds);

        // set the view selected_tab variable based on the tab page parameter
        $tab = $this->_request->getParam('tab', 'public');

        if ($tab == 'mylibraries')
            $selected_tab = 4;
        else if ($tab == 'myparts')
            $selected_tab = 2; 
        else
            $selected_tab = 1;

        $this->view->selected_tab = $selected_tab;
        $this->view->grammars = $grammars;
        $this->view->myLibraryGrammars = $myLibraryGrammars;

    }

    public function exportAction() {
    
        $export_type = $this->getRequest()->getParam('type');
        if ($export_type == "1") {
            $filename = 'my_parts_tab_delim.txt';
            $type = 'TAB';
        }
        else if ($export_type == "0") {
            $filename = 'my_parts_fasta.fasta';
            $type = 'FASTA';
        }

        $this->_helper->layout()->disableLayout();
        $this->getResponse()
             ->setHeader('Content-Disposition', 'attachment; filename='. $filename)
             ->setHeader('Content-type', 'application/octet-stream');

        $dbParts = new Application_Model_DbTable_Parts();
        $parts = $dbParts->find($this->getRequest()->getParam('part_id'));
        foreach ($parts as $part) {
            $this->view->export .= $part->export($type);   
        }
    }
    
    public function importAction() {

        // instantiate the Import Parts Form
        $form = new Parts_Form_ImportParts();


        // check to see if the user submitted the form
        if ($this->getRequest()->isPost()) {
            $this->view->headTitle("GenoCAD: Import Parts");
            $data = $this->getRequest()->getPost();

            if ($form->isValid($data)) {

                // if for some reason the format is not passed, then ge
                $format = $this->getRequest()->getParam('import_format', '0');
                $form->import_file->receive();

                // get the library record of the chosen library
                $dbLibraries = new Application_Model_DbTable_Libraries();
                $library = $dbLibraries->find($data["library_id"])->current();

                $filename = $form->import_file->getFileName();
                
                $this->view->library = $library;
                $this->view->messages = Genocad_Utilities_Parts_Import::processFile($format, $filename, $library);
                $this->view->show_form = false;

            } else {
            	$this->view->show_form = true;
            	$this->_helper->layout()->enableLayout();
            }

        } else {
            $this->view->show_form = true;
            $this->_helper->layout()->disableLayout();

        }

        $this->view->form = $form;

    }
    
}

