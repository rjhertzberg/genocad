<?php
/**
 * 
 * @author Russell Hertzberg
 *
 */
class Application_Model_DbTable_Libraries extends Zend_Db_Table_Abstract
{

    protected $_name = 'libraries';
	protected $_primary = 'library_id';
    protected $_dependentTables = array('Application_Model_DbTable_Designs', 'Application_Model_DbTable_LibraryParts');
    protected $_rowClass = 'Application_Model_DbTable_Row_Library';

    protected $_referenceMap    = array(
        'Grammars' => array(
            'columns'           => 'grammar_id',
            'refTableClass'     => 'Application_Model_DbTable_Grammars',
            'refColumns'        => 'grammar_id'
        )
    );

    public function getLibrary($id) {

        return ($this->find($id)->current());

    }

    public function addLibrary ($grammar_id, $name, $description, $user_id, $addSpecialChars = true) {

    	$data = array (
    				'grammar_id' => $grammar_id,
    				'name' => $name,
    				'description' => $description,
    				'user_id' => $user_id,
    				'last_modified' => new Zend_Db_Expr('NOW()')
    			);

    	$lib_id = $this->insert($data);
    			
    	// add parts for the rc, plasmids, and chromosomes
    	if ($addSpecialChars) {
    		$dbParts = new Application_Model_DbTable_Parts();
    		$dbParts->addSpecialCasePart($lib_id, $grammar_id, '[');
    		$dbParts->addSpecialCasePart($lib_id, $grammar_id, ']');
    		$dbParts->addSpecialCasePart($lib_id, $grammar_id, '(');
    		$dbParts->addSpecialCasePart($lib_id, $grammar_id, ')');
    		$dbParts->addSpecialCasePart($lib_id, $grammar_id, '{');
    		$dbParts->addSpecialCasePart($lib_id, $grammar_id, '}');
    	}
    	
    	return($lib_id);
    }

    public function cloneLibrary ($library_id, $grammar_id, $name, $description, $user_id) {

        // retrieve the existing library record
        $library = $this->getLibrary($library_id);

        // insert a new record based on the passed parameters
        $new_id = $this->addLibrary($grammar_id, $name, $description, $user_id);

        // get all of the parts for the library that is being cloned
        $parts = $library->getParts();

        $dbLibraryParts = new Application_Model_DbTable_LibraryParts();

        // loop through each of the parts and add them to the new library
        foreach ($parts as $part) {
            $dbLibraryParts->addPart($new_id, $part->part_id);
        }

    }


    /**
     * Returns a rowset of libraries records for a given grammar_id, which are owned
     * by the authenticated user, or are publicly available libraries if the 
     * $include_public is set to true.
     * 
     * If the user is not logged in, then it will return only public libraries.
     * If the user is logged in, then it will return user-owned libraries unless the 
     * include_public parameter is set to true.  In that case, it will also
     * include public libraries.
     * 
     * @param $grammar_id
     * @param $include_public
     */
    public function getLibrariesByGrammar($grammar_id, $include_public = false, $include_user = false) {

        $select  = $this->select()->where('grammar_id = ?', $grammar_id);

        if ($include_user && Genocad_Application::isLoggedIn()) {
            if ($include_public) {
                $select->where('user_id = 0 or user_id = ?', Genocad_Application::getUserId());
            } else {
                $select->where('user_id = ?', Genocad_Application::getUserId());
            }
        } else {

            $select->where('user_id = ?', $include_public ? 0 : -1);

        }

        return ($this->fetchAll($select));

    }

    /**
     * Returns a rowset of libraries records that are owned by the authenticated
     * user based on the provided grammar_id.
     * 
     * @param integer $grammar_id
     */
    public function findMyLibraries($grammar_id) {

        return ($this->getLibrariesByGrammar($grammar_id, false, true));

    }

    /**
     * Returns a rowset of libraries records that are owned by the authenticated user.
     * 
     */
    public function getUserLibraries() {

        $select  = $this->select()->where('user_id = ?', (Genocad_Application::isLoggedIn() ? Genocad_Application::getUser()->user_id : -1))
                                  ->order('grammar_id');
        return ($this->fetchAll($select));

    }
    
}

