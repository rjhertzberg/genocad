<?php

class Parts_Form_MapAttribute extends Genocad_Form
{


    public function init()
    {
        
        $attribute_id = new Zend_Form_Element_Hidden('attribute_id');
        $attribute_id ->setDecorators($this->hiddenDecorators);
        $part_id = new Zend_Form_Element_Hidden('part_id');
        $part_id ->setDecorators($this->hiddenDecorators);
        $part_attribute_id = new Zend_Form_Element_Hidden('part_attribute_id');
        $part_attribute_id ->setDecorators($this->hiddenDecorators);
        
        $map_part_id = new Zend_Form_Element_Select('map_part_id');
        $map_part_id -> setLabel('Attribute Part')
                 -> setAttrib('style', 'width: 250px;')
                 -> setDecorators($this->elementDecorators);
        
        $map_value = new Zend_Form_Element_Text('map_value');
        $map_value -> setLabel('Value')
        	  -> setAttrib('size', 10)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');      
        
		$save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Save Mapping')
              -> setDecorators($this->buttonDecorators);
                    
        $this->addElements(array($attribute_id, $part_id, $part_attribute_id, $map_part_id, $map_value));

        $this->setAttrib("id", "map-attribute");

    }

}

?>