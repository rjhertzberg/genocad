<?php

class Grammar_Form_Import extends Genocad_Form
{

    public function init()
    {

        $file = new Zend_Form_Element_File('file_name');
        $file -> setLabel('Import File')
              -> setAttrib('size', 40)
              -> setRequired(true)
              -> setDecorators($this->fileDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $step = new Zend_Form_Element_Hidden('step');
        $step-> setValue('1');

        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Import Grammar')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($file, $step, $save));

        $this->setAttrib("id", "form_import");

    }

}
