<?php

class Application_Model_DbTable_Categories extends Zend_Db_Table_Abstract
{

    protected $_name = 'categories';
    protected $_primary = 'category_id';
    protected $_dependentTables = array('Application_Model_DbTable_CategoryParts',
                                        'Application_Model_DbTable_CategoryAttributes',
                                        'Application_Model_DbTable_CategoryAttributeLists',
    									'Application_Model_DbTable_AttributesToPass',
                                        'Application_Model_DbTable_Rules',
                                        'Application_Model_DbTable_RuleTransform');
    protected $_rowClass = 'Application_Model_DbTable_Row_Category';

    protected $_referenceMap    = array(
        'Grammars' => array(
            'columns'           => 'grammar_id',
            'refTableClass'     => 'Application_Model_DbTable_Grammars',
            'refColumns'        => 'grammar_id',
            'onDelete'          => self::CASCADE
        ),
        'GenbankQualifiers' => array(
            'columns'           => 'genbank_qualifier_id',
            'refTableClass'     => 'Application_Model_DbTable_GenbankQualifiers',
            'refColumns'        => 'genbank_qualifier_id'
        ),
        'StartingCategory' => array(
            'columns'           => 'category_id',
            'refTableClass'     => 'Application_Model_DbTable_Grammars',
            'refColumns'        => 'starting_category_id'
        )
    );


    public function addCategory ($data) {
        $row = $this->createRow($data);
        $row->save();
        return ($row);
    }

    /**
     * 
     * @param int $category_id
     */
    public function deleteCategory ($category_id) {
        $rows = $this->find($category_id);
        if ($rows) {
            $rows->current()->delete();
        }
    }

    
    /**
     * 
     * 
     * @param Grammar_Form_Category $form
     */
    public function saveCategoryForm(Grammar_Form_Category $form) {

        $grammar_id = $form->getValue('grammar_id');
        $category_id = $form->getValue('category_id');

        // if the category_id is null, then it's a new row
        if ($category_id == '') {

            $data = array (
                'letter' => $form->getValue('letter'),
                'description' => $form->getValue('description'),
                'description_text' => $form->getValue('description_text'),
                'icon_name' => $form->getValue('icon_name'),
                'grammar_id' => $form->getValue('grammar_id'),
                'genbank_qualifier_id' => (int) $form->getValue('genbank_qualifier_id')
            );

            $row = $this->addCategory($data);

        } else {
            // retrieve the category record for the given category_id
            $row = $this->find($category_id)->current();

            // set the proper values for the design record
            $row->letter = $form->getValue('letter');
            $row->description = $form->getValue('description');
            $row->description_text = $form->getValue('description_text');
            $row->icon_name = $form->getValue('icon_name');
            $row->genbank_qualifier_id = (int) $form->getValue('genbank_qualifier_id');

            $row->save();
        }

        // set the design_id variable to the value of the PK for the row
        $category_id = $row->category_id;

        return ($row);

    }

    public function getCategoryByLetterAndGrammar($letter, $grammar_id, $category_id) {
        $sql = sprintf("letter = '%s' and grammar_id = %s", $letter, $grammar_id);
        if ($category_id != "") {
            $sql .= sprintf(" and category_id != %s", $category_id);
        }
        return ($this->fetchRow($this->select()->where($sql)));
    }


}
?>

