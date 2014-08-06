<?php

class profile_Form_Profile extends Genocad_Form
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
               -> addValidator(new Zend_Validate_EmailAddress());

        $first_name = new Zend_Form_Element_Text('first_name');
        $first_name -> setLabel('First Name')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $last_name = new Zend_Form_Element_Text('last_name');
        $last_name -> setLabel('Last Name')
               -> setAttrib('size', 30)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $institution = new Zend_Form_Element_Text('institution');
        $institution -> setLabel('Institution')
               -> setAttrib('size', 40)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $position = new Zend_Form_Element_Text('position');
        $position -> setLabel('Position')
               -> setAttrib('size', 40)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $country = new Zend_Form_Element_Text('country');
        $country -> setLabel('Country')
               -> setAttrib('size', 40)
               -> setRequired(true)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $address = new Zend_Form_Element_Text('address');
        $address -> setLabel('Address')
               -> setAttrib('size', 40)
               -> setRequired(false)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $city = new Zend_Form_Element_Text('city');
        $city -> setLabel('City')
               -> setAttrib('size', 40)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $state = new Zend_Form_Element_Text('state');
        $state -> setLabel('State/Province')
               -> setAttrib('size', 2)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $zip = new Zend_Form_Element_Text('zip');
        $zip -> setLabel('Zip/Postal Code')
               -> setAttrib('size', 5)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $telephone = new Zend_Form_Element_Text('telephone');
        $telephone -> setLabel('Telephone')
               -> setAttrib('size', 20)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $website = new Zend_Form_Element_Text('website');
        $website -> setLabel('Website')
               -> setAttrib('size', 40)
               -> setDecorators($this->elementDecorators)
               -> addFilter('StripTags')
               -> addFilter('StringTrim');

        $reason = new Zend_Form_Element_Textarea('why_ask_for_account');
        $reason -> setLabel('Why do you want an account?')
                -> setDecorators($this->elementDecorators)
                -> addFilter('StripTags')
                -> addFilter('StringTrim')
                -> setAttribs(array('rows'=>3,'cols'=>50));
                
        $url = new Zend_Form_Element_Text('my_url');
        $url -> setAttribs(array('size' => 60, 'style' => 'display:none;visibility:hidden;', 'alt' => 'Spamfilter -- leave blank'))
        	 -> setValue('')
        	 -> addFilter('StripTags')
        	 -> addFilter('StringTrim');            
                 

        $save = new Zend_Form_Element_Submit('submit');
        $save -> setLabel('Request Account')
              -> setDecorators($this->buttonDecorators);

        $this->addElements(array($login, $first_name, $last_name, $institution, $position, $country, $address, $city, $state, $zip, $telephone, $website, $reason, $url, $save));

        $this->setAttrib("id", "form_profile");
    }
    
}

