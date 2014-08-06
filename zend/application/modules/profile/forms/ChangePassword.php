<?php

class profile_Form_ChangePassword extends Genocad_Form
{

    public function init()
    {

        $passwd = new Zend_Form_Element_Password('password');
        $passwd -> setLabel('Current Password')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $new_passwd = new Zend_Form_Element_Password('new_password');
        $new_passwd -> setLabel('New Password')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $confirm_passwd = new Zend_Form_Element_Password('confirm_password');
        $confirm_passwd -> setLabel('Confirm New Password')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Change Password')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($passwd, $new_passwd, $confirm_passwd, $save));

        $this->setAttrib("id", "form_password");
    }

}

