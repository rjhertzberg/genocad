<?php

class Application_Model_DbTable_Row_AttributeGrammar extends Zend_Db_Table_Row_Abstract
{

    public function getFormItem ($type) {
    	$item = new Zend_Form_Element_Textarea($type);
    	if ($type == 'code_init') {
        	$item -> setValue($this->code_init);
    	} else {
    		$item ->setValue($this->code_end);
    	}		  

    	$item-> setAttrib('cols', 60)
              -> setAttrib('rows', 5)
              -> setRequired(true)
              -> addFilter('StringTrim');
        //$item = $type;      
     	return ($item);         
    }
    
}
?>