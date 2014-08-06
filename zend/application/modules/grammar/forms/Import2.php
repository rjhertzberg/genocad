<?php

class Grammar_Form_Import2 extends Genocad_Form
{

    public function init()
    {

        $choice = new Zend_Form_Element_Radio('icon_choice');
        
        $choice->setLabel('Choose an Option')
               ->setRequired(true)
               ->setDecorators($this->elementDecorators)
               ->addMultiOption('1', "USE EXISTING - Use the existing Icon Set.")
               ->addMultiOption('2', "CREATE NEW - Create a new Icon Set and link it to the imported grammar.");

        $new_icon_set = new Zend_Form_Element_Text('new_icon_set');
        $new_icon_set ->setLabel('New Icon Set Name')
                      ->setDecorators($this->elementDecorators)
                      ->setRequired(true)
                      ->addFilter('StripTags')
                      ->addFilter('StringTrim')
                      ->setDescription('Must be alpha-numeric (no spaces or special characters).')
                      //->addValidator(new Zend_Validate_Alnum(array('allowwhitespace' => false)))
                      ->setAttrib('size', '20')
                      ->addValidator(new Genocad_Validate_IconSetName(new Application_Model_ImageSets()));

        $this->addElements(array($choice, $new_icon_set));

    }

}
