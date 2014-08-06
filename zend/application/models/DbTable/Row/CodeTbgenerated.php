<?php

class Application_Model_DbTable_Row_CodeTbgenerated extends Zend_Db_Table_Row_Abstract
{
    /**
     * Returns a Zend_Form_Element either as a text box or a textarea depending on whether we are calling type or code
     * 
     * @param String $display
     * @returns Zend_Form_Element
     */
    public function getFormItem($display) {

        // if this is the type, then we will display the type in an editable field
        if ($display == "type") {
            $item = new Zend_Form_Element_Text($display.$this->id);
            $item->setValue($this->type);
            
        } else {
        	// this is the code block
        	$item = new Zend_Form_Element_Textarea($display.$this->id);
        	$item->setValue($this->code)
        		-> setAttrib('cols', 75)
              	-> setAttrib('rows', 8)
              	-> addFilter('StringTrim');
        }
        
        $item -> setLabel($display)
        	 -> setBelongsTo('code_tbgenerated');
              
        return ($item);

    }

}
?>