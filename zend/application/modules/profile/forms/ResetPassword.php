<?php

class profile_Form_ResetPassword extends Genocad_Form
{

    public function init()
    {

        $login = new Zend_Form_Element_Text('login');
        $login -> setLabel('Email')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim')
               -> addValidator(new Zend_Validate_Db_RecordExists(
                                       array(
                                           'table' => 'users',
                                           'field' => 'login'
                                       )
                                   )
                              );

        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Reset Password')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($login, $save));

        $this->setAttrib("id", "form_reset");
    }

}
