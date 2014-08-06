<?php

class simulate_Form_Run extends Genocad_Form
{

    public function init()
    {
        $this->setName('run-simulation');
        $this->setAttrib('class', 'ui-content');

        $design_id = new Zend_Form_Element_Hidden('design_id');
        $design_id -> setDecorators($this->hiddenDecorators);

        $duration = new Zend_Form_Element_Text('duration');
        $duration-> setDecorators($this->elementDecorators)
                 -> setAttrib('size', '5')
                 -> setLabel('Duration (in seconds)');

        $int_time = new Zend_Form_Element_Text('int_time');
        $int_time-> setDecorators($this->elementDecorators)
                 -> setAttrib('size', '5')
                 -> setLabel('Interval Time (in seconds)');

        $intervals = new Zend_Form_Element_Text('intervals');
        $intervals-> setDecorators($this->elementDecorators)
                 -> setAttribs(array('size'=>'5', 'disabled'=>'true'))
                 -> setLabel('# Intervals');
                 
        $submit = new Zend_Form_Element_Submit('submit');
        $submit -> setLabel('Simulate')
               -> setDecorators($this->buttonDecorators);
             
        $this->addElements( array($design_id, $duration, $int_time, $intervals, $submit));

    }


}

