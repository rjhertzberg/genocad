<?php

class Design_Form_Design extends Genocad_Form
{

    public function init()
    {

        $design_id = new Zend_Form_Element_Hidden('design_id');
        $design_id ->setDecorators($this->hiddenDecorators);
        
        $library_id = new Zend_Form_Element_Hidden('design_library_id');
        $library_id ->setDecorators($this->hiddenDecorators);

        $history = new Zend_Form_Element_Hidden('design_steps');
        $history ->setDecorators($this->hiddenDecorators);
        
        $name = new Zend_Form_Element_Text('design_name');
        $name -> setLabel('Name')
              -> setAttrib('size', 45)
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');


        $description = new Zend_Form_Element_TextArea('design_description');
        $description -> setLabel('Description')
                     -> setDecorators($this->elementDecorators)
                     -> addFilter('StripTags')
                     -> addFilter('StringTrim')
                     -> setAttribs(array('rows'=>10,'cols'=>60));
                 

        $save = new Zend_Form_Element_submit('submit');
        $save -> setLabel('Save Design')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($design_id, $library_id, $history, $name, $description));

        $this->setAttrib("id", "form_design");
        //$this->setAttrib("action", "/design/index/save");
        //$this->setAttrib("method", "post");
    }

}
