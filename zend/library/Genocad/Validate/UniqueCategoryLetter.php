<?php
class Genocad_Validate_UniqueCategoryLetter extends Zend_Validate_Abstract
{
    const LETTER_EXISTS = 'letterExists';

    protected $_messageTemplates = array(
        self::LETTER_EXISTS   => 'The Category Letter "%value%" is already in use for this grammar.',
    );

    public function __construct(Application_Model_DbTable_Categories $model) {
        $this->_model = $model;
    }

    public function isValid($value, $context = null)
    {  

        $this->_setValue($value);
        
        $category = $this->_model->getCategoryByLetterAndGrammar($value, $context["grammar_id"], $context["category_id"]);
        if (null === $category) {
            return true;
        }
        
        $this->_error(self::LETTER_EXISTS);
        return false;

    }
}
