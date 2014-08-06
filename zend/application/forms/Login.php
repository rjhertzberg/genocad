<?php

class Application_Form_Login extends Genocad_Form
{

    public function init()
    {

        $refurl = new Zend_Form_Element_Hidden('refurl');
        $refurl -> setDecorators($this->hiddenDecorators);
        
        $username = new Zend_Form_Element_Text('username');
        $username -> setLabel('Username')
                    -> setRequired(true)
                    -> setDecorators($this->elementDecorators)
                    -> addFilter('StripTags')
                    -> addFilter('StringTrim');
                 

        $password = new Zend_Form_Element_Password('password');
        $password -> setLabel('Password')
                    -> setRequired(true)
                    -> setDecorators($this->elementDecorators)
                    -> addFilter('StripTags')
                    -> addFilter('StringTrim');
                 

        $login = new Zend_Form_Element_Submit('submit');
        $login -> setLabel('Log In')
               -> setDecorators($this->buttonDecorators);

        $this->addElements(array($refurl, $username, $password, $login));


    }
   
    public function loadDefaultDecorators()
    {
        $this->setDecorators(array(
            'FormElements',
            array('HtmlTag', array('tag' => 'table', 'class' => 'user-form')),
            array('Description', array('class'=> 'form-error', 'placement' => 'prepend')),
            'Form'
        ));
    }
}
