<?php

class Grammar_Form_Code extends Genocad_Form
{


    public function init()
    {
        
        $grammar_id = new Zend_Form_Element_Hidden('grammar_id');
        $grammar_id ->setDecorators($this->hiddenDecorators);
        
                     
       $type = new Zend_Form_Element_Text('type');
       $type -> setLabel('Type')
       		  -> setAttrib('size', 20)
              -> setRequired(true)
              -> setDecorators($this->elementDecorators);       

       $code = new Zend_Form_Element_Textarea('code');
       $code -> setLabel('Code')
             -> setAttrib('cols', 60)
             -> setAttrib('rows', 5)
             -> setRequired(true)
             -> setDecorators($this->elementDecorators)
             -> addFilter('StringTrim');       
             
        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Save Code')
              -> setDecorators($this->buttonDecorators);
                    
        $this->addElements(array($grammar_id, $type, $code));

        $this->setAttrib("id", "form_code");

    }

}
