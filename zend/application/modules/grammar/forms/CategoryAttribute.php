<?php

class Grammar_Form_CategoryAttribute extends Genocad_Form
{


    public function init()
    {
        
        $category_id = new Zend_Form_Element_Hidden('category_id');
        $category_id ->setDecorators($this->hiddenDecorators);
        
        $grammar_id = new Zend_Form_Element_Hidden('grammar_id');
        $grammar_id ->setDecorators($this->hiddenDecorators);

        
        $letter = new Zend_Form_Element_Text('letter');
        $letter -> setLabel('Letter')
              -> setAttrib('size', 5)
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $description = new Zend_Form_Element_Text('description');
        $description -> setLabel('Description')
              -> setAttrib('style', 'width: 250px;')
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $attributes = new Zend_Form_Element_Select('category_attributes');
        $attributes -> setLabel('Attributes')
              -> setAttrib('style', 'width: 250px;')
              -> setDecorators($this->elementDecorators)
              -> addMultiOption('', '- Select Icon -');

        $dbAttributes = new Application_Model_DbTable_CategoryAttributes();
              
        $catAttributes = $dbAttributes->fetchAll($dbAttributes->select()->where('category_id = ?', $category_id)->order('qualifier'));
        foreach ($catAttributes as $attribute) {
            $attributes ->addMultiOption($attribute->id,$attribute->name);
        }

        $add = new Zend_Form_Element_Submit('addAttribute');
        $add -> setLabel('Add Attribute')
        	 -> setDecorators($this->buttonDecorators);
        	 
        $edit = new Zend_Form_Element_Submit('editAttribute');
        $edit -> setLabel('Edit Attribute')
        	  -> setDecorators($this->buttonDecorators);
        	  
        $delete = new Zend_Form_Element_Submit('removeAttribute');
        $delete -> setLabel('Delete Attribute')
        		-> setDecorators($this->buttonDecorators);
        		      
        $this->addElements(array($category_id, $grammar_id, $letter, $description, $attributes));

        $this->setAttrib("id", "form_category");

    }

}
