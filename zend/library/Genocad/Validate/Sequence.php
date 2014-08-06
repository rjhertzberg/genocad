<?php
class Genocad_Validate_Sequence extends Zend_Validate_Abstract
{
    const INVALID_SEQUENCE = 'invalidSequence';

    protected $_messageTemplates = array(
        self::INVALID_SEQUENCE   => "The sequence can only be comprised of A, G, C and T",
    );

    public function isValid($value)
    {  
        
        $segment = strtolower($value);
        $segment = preg_replace('/\s+/','',$segment);
        $segment = str_replace("a","",$segment);
        $segment = str_replace("g","",$segment);
        $segment = str_replace("c","",$segment);
        $segment = str_replace("t","",$segment);
        $segment = str_replace("||","",$segment); // Only for model sequences

        if (strlen($segment)){
            $this->_error(self::INVALID_SEQUENCE);
            return false;
        }
        return true;
    }
}
