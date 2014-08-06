<?php

class Application_Model_DbTable_AttributeGrammars extends Zend_Db_Table_Abstract
{

    protected $_name = 'attribute_grammar';
    protected $_primary = 'grammar_id';
    protected $_rowClass = 'Application_Model_DbTable_Row_AttributeGrammar';

    protected $_referenceMap    = array(
        'Grammars' => array(
            'columns'           => 'grammar_id',
            'refTableClass'     => 'Application_Model_DbTable_Grammars',
            'refColumns'        => 'grammar_id'
        )
    );

}

?>

