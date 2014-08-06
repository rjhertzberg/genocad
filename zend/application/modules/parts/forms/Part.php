<?php

class parts_Form_Part extends Zend_Form
{

    public function init()
    {
        $this->setName('part');
        $this->setAttrib('class', 'ui-content');

        $id = new Zend_Form_Element_Hidden('id');
        $id ->addFilter('Int')
            ->setDecorators(array(
                                array('ViewHelper',
                                    array('HtmlTag' => array('tag'=>'dd', 'style'=> 'display:none'))
                            )));

        $design_count = new Zend_Form_Element_Hidden('design_count');
        $design_count ->addFilter('Int')
            ->setDecorators(array(
                                array('ViewHelper',
                                    array('HtmlTag' => array('tag'=>'dd', 'style'=> 'display:none'))
                            )));                   
                            
        $user_id = new Zend_Form_Element_Hidden('user_id');
        $user_id ->addFilter('Int')
                 ->setDecorators(array(
                                    array('ViewHelper',
                                       array('HtmlTag' => array('tag'=>'dd', 'style'=> 'display:none'))
                                 )));

        $orig_grammar_id = new Zend_Form_Element_Hidden('orig_grammar_id');
        $orig_grammar_id ->addFilter('Int')
                         ->setDecorators(array(
                                    array('ViewHelper',
                                       array('HtmlTag' => array('tag'=>'dd', 'style'=> 'display:none'))
                                 )));
                                 

        $part_id = new Zend_Form_Element_Text('part_id');
        $part_id ->setLabel('Part ID:')
              ->addFilter('StripTags')
              ->addFilter('StringTrim')
              ->setAttrib('size', '75')
              ->setAttrib('disabled', true);

        $name = new Zend_Form_Element_Text('description');
        $name ->setLabel('Part Name:')
              ->setRequired(true)
              ->addFilter('StripTags')
              ->addFilter('StringTrim')
              ->setAttrib('size', '75');

        $segment = new Zend_Form_Element_Textarea('segment');
        $segment ->setLabel('Sequence:')
                     ->setRequired(true)
                     ->setAttrib('rows', '4')
                     ->setAttrib('cols', '75')
                     ->addFilter('StripTags')
                     ->addValidator(new Genocad_Validate_Sequence())
                     ->addFilter('StringTrim');

        $description = new Zend_Form_Element_Textarea('description_text');
        $description ->setLabel('Description:')
                     ->setAttrib('rows', '2')
                     ->setAttrib('cols', '75')
                     ->addFilter('StripTags')
                     ->addFilter('StringTrim');

        $submit = new Zend_Form_Element_Submit('submit');
        $submit->setAttrib('id', 'submitbutton')
               ->setAttrib('class', 'ui-button');

        $grammar_id = new Zend_Form_Element_Select('grammar_id');
        $grammar_id->addMultiOption('','- Select Grammar - ');
        $grammar_id->setLabel('Grammar')
                   ->setRequired(true)
                   ->setAttrib('onChange', 'partChangeGrammar(this.value);');

        $category_id = new Zend_Form_Element_Multiselect('category_id');
        $category_id->setLabel('Category:')
                    ->setRequired(true)
                    ->addValidator('NotEmpty')
                    ->setAttrib('size', '10')
                    ->setAttrib('style', 'width: 300px;')
                    ->setRegisterInArrayValidator(false);

                    
        $library = new Zend_Form_Element_MultiSelect('library_id');
        $library->setLabel('Add to Library:')
                ->setRequired(true)
                ->setAttrib('size', '5')
                ->setRegisterInArrayValidator(false);

        $this->addElements( array($id, $user_id, $design_count, $orig_grammar_id, $part_id, $name, $segment, $description, $grammar_id, $library, $category_id));

    }



}

