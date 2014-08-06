<?php

class Application_Form_Contact extends Genocad_Form
{

    public function init()
    {

        $email = new Zend_Form_Element_Text('email');
        $email -> setLabel('Email')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $subject = new Zend_Form_Element_Text('subject');
        $subject -> setLabel('Subject')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $message = new Zend_Form_Element_Textarea('message');
        $message -> setLabel('Message')
                -> setDecorators($this->elementDecorators)
                -> setRequired(true)
                -> addFilter('StripTags')
                -> addFilter('StringTrim')
                -> setAttribs(array('rows'=>3,'cols'=>50));

        $url = new Zend_Form_Element_Text('my_url');
        $url -> setAttribs(array('size' => 60, 'style' => 'display:none;visibility:hidden;', 'alt' => 'Spamfilter -- leave blank'))
        	 -> setValue('')
        	 -> addFilter('StripTags')
        	 -> addFilter('StringTrim');        
                 
        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Submit')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($email, $subject, $message, $url, $save));

        $this->setAttrib("id", "form_contact");
    }

}
