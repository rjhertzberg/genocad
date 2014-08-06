<?php

class Grammar_Form_Attributes extends Genocad_Form
{


    public function init()
    {
        
        $category_id = new Zend_Form_Element_Hidden('category_id');
        $category_id ->setDecorators($this->hiddenDecorators);
        
        $letter = new Zend_Form_Element_Text('letter');
        $letter -> setLabel('Letter')
        	  -> setAttrib('disabled', 'disabled')
              -> setAttrib('size', 5)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $description = new Zend_Form_Element_Text('description');
        $description -> setLabel('Description')
        	  -> setAttrib('disabled', 'disabled')
              -> setAttrib('style', 'width: 250px;')
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $attributes = new Zend_Form_Element_Select('category_attributes');
        $attributes -> setLabel('Attributes')
              -> setAttrib('style', 'width: 250px;')
              -> setDecorators($this->elementDecorators)
              -> setAttrib('size', 10);
	      
        $this->addElements(array($category_id, $letter, $description, $attributes));

        $this->setAttrib("id", "form_attributes");

    }

}
