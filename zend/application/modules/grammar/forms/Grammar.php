<?php

class Grammar_Form_Grammar extends Genocad_Form
{


    public function init()
    {
        $grammar_id = new Zend_Form_Element_Hidden('grammar_id');
        $grammar_id ->setDecorators($this->hiddenDecorators);
        $isAttribute = new Zend_Form_Element_Hidden('is_attribute');
        $isAttribute ->setDecorators($this->hiddenDecorators);
        
        $name = new Zend_Form_Element_Text('name');
        $name -> setLabel('Name')
              -> setAttrib('size', 50)
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $description = new Zend_Form_Element_Textarea('description');
        $description -> setLabel('Description')
              -> setAttrib('cols', 60)
              -> setAttrib('rows', 2)
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');

        $category_id = new Zend_Form_Element_Select('starting_category_id');
        $category_id -> setLabel('Starting Category')
              -> setDecorators($this->elementDecorators)
              -> setRequired(true)
              -> setAttrib('style', 'width: 200px;')
              -> addMultiOption('', '- Select Category -');
              
        $icon = new Zend_Form_Element_Select('icon_set');
        $icon -> setLabel('Icon Set')
              -> setDescription('<a href="#" id="image_set_browse">Preview</a>')
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> setAttrib('style', 'width: 200px;')
              -> addMultiOption('', '- Select Icon Set -');
            
        $image_sets = new Application_Model_ImageSets();
        foreach ($image_sets->getImageSets() as $set) {
            $icon->addMultiOption($set, $set);
        }
        
        $include_libraries = new Zend_Form_Element_MultiCheckbox('include_libraries');
        $include_libraries -> setLabel('Include Libraries')
        			-> setDecorators($this->elementDecorators)
        			->setRequired(false);

        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Create New Grammar')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($grammar_id, $isAttribute, $name, $description, $category_id, $icon, $include_libraries, $save));

        $this->setAttrib("id", "form_grammar");

    }

}
