<?php

class Grammar_Form_Attribute extends Genocad_Form
{


    public function init()
    {
        
        $attribute_id = new Zend_Form_Element_Hidden('id');
        $attribute_id ->setDecorators($this->hiddenDecorators);
        $category_id = new Zend_Form_Element_Hidden('category_id');
        $category_id ->setDecorators($this->hiddenDecorators);
        
        $name = new Zend_Form_Element_Text('name');
        $name -> setLabel('Attribute')
        	  -> setAttrib('size', 20)
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');
              
        $description = new Zend_Form_Element_Text('description');
        $description -> setLabel('Description')
        	  -> setAttrib('size', 20)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $display_order = new Zend_Form_Element_Text('display_order');
        $display_order -> setLabel('Display Order')
        	  -> setAttrib('size', 2)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');      
              
		$attributeType = new Zend_Form_Element_Select('attribute_type');
        $attributeType -> setLabel('Attribute Type')
                 -> setAttrib('style', 'width: 250px;')
                 -> setDecorators($this->elementDecorators);

        $dbAttributeType = new Application_Model_DbTable_AttributeTypes();
        $types = $dbAttributeType->fetchAll($dbAttributeType->select()->order('id'));
        foreach ($types as $type) {
            $attributeType ->addMultiOption($type->id,$type->name);
        }
              

       $selected_category_id = new Zend_Form_Element_Multiselect('selected_categories');
       $selected_category_id->setLabel('Categories')
              ->setAttrib('size', '10')
              ->setAttrib('style', 'width: 300px')
              ->setRegisterInArrayValidator(false)
       		  ->setDecorators($this->elementDecorators);
              

		$save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Save Attribute')
              -> setDecorators($this->buttonDecorators);
                    
        $this->addElements(array($attribute_id, $category_id, $name, $description, $display_order, $attributeType, $selected_category_id));

        $this->setAttrib("id", "form_attribute");

    }

}
