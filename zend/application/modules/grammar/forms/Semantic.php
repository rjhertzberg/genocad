<?php

class Grammar_Form_Semantic extends Genocad_Form
{


    public function init()
    {
        
        $rule_id = new Zend_Form_Element_Hidden('rule_id');
        $rule_id ->setDecorators($this->hiddenDecorators);
        
        $semantic_id = new Zend_Form_Element_Hidden('semantic_id');
        $semantic_id->setDecorators($this->hiddenDecorators);
        
        //$category_id = New Zend_Form_Element_Select('category_id');
        //$category_id -> setLabel('Category List')
        //      -> setDecorators($this->elementDecorators)
        //      -> setRequired(false)
        //      -> setAttrib('style', 'width: 200px;')
        //      -> addMultiOption('', '- Select Category -')
        //      -> setAttrib('onChange', 'insertCode(this.value);');
              
       $attribute_id = New Zend_Form_Element_Select('attribute_id');
       $attribute_id -> setLabel('Attribute List')
       		  -> setDecorators($this->elementDecorators)
       		  -> setRequired (false)
       		  -> setAttrib('style', 'width: 200px;')
       		  -> addMultiOption('', '- Select Attribute -')
       		  -> setAttrib('onChange', 'insertCode(this.value);');      
              
                     
       $action_code = new Zend_Form_Element_Textarea('action_code');
       $action_code -> setLabel('Semantic Action')
             -> setAttrib('cols', 100)
             -> setAttrib('rows', 20)
             -> setRequired(true)
             -> setDecorators($this->elementDecorators)
             -> addFilter('StringTrim');       
             
        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Save Code')
              -> setDecorators($this->buttonDecorators);
                    
        $this->addElements(array($rule_id, $semantic_id, $attribute_id, $action_code));

        $this->setAttrib("id", "form_semantic");

    }

}

?>