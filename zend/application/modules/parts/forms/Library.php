<?php

class Parts_Form_Library extends Zend_Form
{

    public function init()
    {
        $this->setName('library');
        //$this->setAttrib('class', 'ui-content');

        $id = new Zend_Form_Element_Hidden('library_id');
        $id ->addFilter('Int')
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

        $clone_id = new Zend_Form_Element_Hidden('clone_library_id');
        $clone_id ->addFilter('Int')
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
                                  
        $grammars = new Application_Model_DbTable_Grammars();
        $grammar_id = new Zend_Form_Element_Select('grammar_id');
        $grammar_id->addMultiOption('','- Select Grammar - ');
        $grammar_id->setLabel('Grammar')
                   ->setRequired(true)
                   ->addValidator('NotEmpty')
                   ->addMultiOptions($grammars->getGrammarList());

        $name = new Zend_Form_Element_Text('name');
        $name ->setLabel('Name:')
              ->setRequired(true)
              ->addFilter('StripTags')
              ->addFilter('StringTrim')
              ->addValidator('NotEmpty')
              ->setAttrib('size', '60');

        $description = new Zend_Form_Element_Textarea('description');
        $description ->setLabel('Description:')
                     ->setAttrib('rows', '5')
                     ->setAttrib('cols', '60')
                     ->addFilter('StripTags')
                     ->addFilter('StringTrim');


        $this->addElements(array($id, $user_id, $orig_grammar_id, $grammar_id, $name, $description));
    }


}

