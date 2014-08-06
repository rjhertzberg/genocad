<?php
class Genocad_Validate_IconSetName extends Zend_Validate_Abstract
{
    const ICONSET_EXISTS = 'iconsetExists';
    const ICONSET_INVALID_NAME = 'iconsetInvalidName';

    protected $_messageTemplates = array(
        self::ICONSET_EXISTS   => 'An Icon Set with the name "%value%" already exists, please choose another name.',
        self::ICONSET_INVALID_NAME   => 'The Icon Set Name must be alpha numeric (no spaces or special characters).'
    );

    public function __construct(Application_Model_ImageSets $model) {
        $this->_model = $model;
    }

    public function isValid($value, $context = null)
    {  

        $this->_setValue($value);

        if ($this->_model->exists($value)) {
            $this->_error(self::ICONSET_EXISTS);
            return false;
        }

        if (!preg_match('!^[\w]*$!', $value)) {
            $this->_error(self::ICONSET_INVALID_NAME);
            return false;
        }

        return true;

    }
}
