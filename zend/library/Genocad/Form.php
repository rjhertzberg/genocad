<?php

class Genocad_Form extends Zend_Form
{

    public $elementDecorators = array(
        'ViewHelper',
        array('Description', array('escape' => false, 'tag' => 'span', 'style'=>'padding-left: 10px')),
        'Errors',
        array(array('data' => 'HtmlTag'), array('tag' => 'td', 'class' => 'element')),
        array('Label', array('tag' => 'td', 'optionalSuffix'=>':', 'requiredSuffix' => ':')),
        array(array('row' => 'HtmlTag'), array('tag' => 'tr', 'valign' => 'top')),
    );

    public $fileDecorators = array(
        'File',
        'Errors',
        array(array('data' => 'HtmlTag'), array('tag' => 'td', 'class' => 'element')),
        array('Label', array('tag' => 'td', 'optionalSuffix'=>':', 'requiredSuffix' => ':')),
        array(array('row' => 'HtmlTag'), array('tag' => 'tr', 'valign' => 'top')),
    );
    
    public $hiddenDecorators = array(
        'ViewHelper'
    );

    public $buttonDecorators = array(
        'ViewHelper',
        array(array('data' => 'HtmlTag'), array('tag' => 'td', 'class' => 'element')),
        array(array('label' => 'HtmlTag'), array('tag' => 'td', 'placement' => 'prepend')),
        array(array('row' => 'HtmlTag'), array('tag' => 'tr')),
    );

    public function loadDefaultDecorators()
    {
        $this->setDecorators(array(
            'FormElements',
            array('HtmlTag', array('tag' => 'table', 'class' => 'user-form')),
            array('Description', array('class'=> 'form-error', 'placement' => 'prepend')),
            array('Form', array('class'=> 'zend-form'))
        ));
    }

}