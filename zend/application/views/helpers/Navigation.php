<?php
/**
 * Navigation helper
 *
 * Call as $this->navigation() in your layout script
 */
class Application_View_Helper_Navigation
{
    public $view;

    public function setView(Zend_View_Interface $view)
    {
        $this->view = $view;
    }

    public function Navigation()
    {
        
        $module = Zend_Controller_Front::getInstance()->getRequest()->getModuleName();
        $html = '<ul>';
        $html .= sprintf('<li class="first %s"><a href="%s">STEP 1: PARTS</a></li>', ($module == 'parts' || $module == 'grammar')  ? 'current' : '' , '/parts');
        $html .= sprintf('<li %s><a href="%s">STEP 2: DESIGN</a></li>', $module == 'design' ? 'class="current"' : '' , '/design');
        $html .= sprintf('<li class="%s"><a href="%s">STEP 3: SIMULATE</a></li>', $module == 'simulate' ? 'current current-last-child ' : 'last-child ' , '/simulate');

        $html .= '</ul>';

        return ($html);

    }

}