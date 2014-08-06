<?php

class Grammar_Form_Category extends Genocad_Form
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
        $description -> setLabel('Name')
              -> setAttrib('style', 'width: 250px;')
              -> setRequired(true)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');
              
        $description_text = new Zend_Form_Element_Textarea('description_text');
        $description_text -> setLabel('Description')
              -> setAttrib('cols', 45)
              -> setAttrib('rows', 3)
              -> setDecorators($this->elementDecorators)
              -> addFilter('StripTags')
              -> addFilter('StringTrim');    

        $icon = new Zend_Form_Element_Select('icon_name');
        $icon -> setLabel('Icon')
              -> setAttrib('style', 'width: 250px;')
              -> setDecorators($this->elementDecorators)
              -> addMultiOption('', '- Select Icon -');

        $genbank = new Zend_Form_Element_Select('genbank_qualifier_id');
        $genbank -> setLabel('Genbank Qualifier')
                 -> setAttrib('style', 'width: 250px;')
                 -> setDecorators($this->elementDecorators)
                 -> addMultiOption('', '- Select Genbank Qualifier -');

        $dbGenbank = new Application_Model_DbTable_GenbankQualifiers();
        $qualifiers = $dbGenbank->fetchAll($dbGenbank->select()->order('qualifier'));
        foreach ($qualifiers as $qualifier) {
            $genbank ->addMultiOption($qualifier->genbank_qualifier_id,$qualifier->qualifier);
        }

        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Save Category')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($category_id, $grammar_id, $letter, $description, $description_text, $genbank, $icon));

        $this->setAttrib("id", "form_category");

    }

}
