<?php

class parts_Form_ImportParts extends Genocad_Form
{

    public function init()
    {
        $this->setName('import-parts');
        $this->setAttrib('class', 'ui-content');
        $this->setAttrib('enctype', 'multipart/form-data');
        $this->setAttrib('action', '/parts/index/import');

        $library_id = new Zend_Form_Element_Select('library_id');
        $library_id-> setLabel('Library to Import into')
                   -> addMultiOption('', '- Select Library -')
                   -> setRequired(true)
                   -> addValidator('NotEmpty')
                   -> setDecorators($this->elementDecorators)
                   ;

        $format = new Zend_Form_Element_Radio('import_format');
        $format-> setLabel('Import Format')
               -> setRequired(true)
               -> addMultiOption('0', 'FASTA')
               -> addMultiOption('1', 'Tab-Delimited')
               -> setDecorators($this->elementDecorators)
               -> setValue('0');

        $file = new Zend_Form_Element_File('import_file');
        $file-> setLabel('File to Import')
             -> addValidator('Size', false, 50102400)
             -> setDecorators($this->fileDecorators)
             -> setAttrib('size', 50)
             -> setRequired(true);
                 

        $submit = new Zend_Form_Element_Submit('submit');
        $submit -> setLabel('Import File')
               -> setDecorators($this->buttonDecorators);
             
    
        $dbLibraries = new Application_Model_DbTable_Libraries();
        $libraries = $dbLibraries->getUserLibraries();
        foreach($libraries as $library) {
            $library_id->addMultiOption($library->library_id, $library->name);
        }
        $this->addElements( array($library_id, $format, $file));

    }



}

