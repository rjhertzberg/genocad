<?php
class Genocad_Validate_UniqueEmail extends Zend_Validate_Abstract
{
    const EMAIL_EXISTS = 'emailExists';

    protected $_messageTemplates = array(
        self::EMAIL_EXISTS   => 'Login "%value%" has already been registered',
    );

    public function __construct(Application_Model_DbTable_Users $model) {
        $this->_model = $model;
    }

    public function isValid($value, $context = null)
    {  
        
        $this->_setValue($value);
        
        $user = $this->_model->getUserByLogin($value);
        if (null === $user) {
            return true;
        }
        
        $this->_error(self::EMAIL_EXISTS);
        return false;

    }
}
