<?php
class Genocad_Application
{

    /*
     *    getUser()
     */
    public static function getUser()
    {

        $user = Zend_Auth::getInstance()->getStorage()->read();
        $user->setTable(new Application_Model_DbTable_Users());
        return($user);

    }

    /*
     *    isLoggedIn()
     */
    public static function isLoggedIn()
    {

        return (Zend_Auth::getInstance()->hasIdentity());

    }


    /**
     * Returns the user_id value for the user who is currently logged in
     * 
     * @returns Integer
     */
    public static function getUserId()
    {
        if (Genocad_Application::isLoggedIn()) {
            return (Genocad_Application::getUser()->user_id);
        } else {
            return (-1);
        }
    }
    
    /*
     *    getPartsList()
     */
    public static function getPartsList()
    {

        $dbPartsList = new Application_Model_DbTable_PartsList();
        $parts_list = $dbPartsList->getPartsListbyUserID(Genocad_Application::getUserId());

        $nsPartsList = new Zend_Session_Namespace('PartsList');
        $nsPartsList->id = $parts_list->id;
        $nsPartsList->user_id = $parts_list->user_id;
        $nsPartsList->updated_on = new Zend_Date();

        return ($parts_list);

    }

    /**
     * Generates a random password and returns it to the calling method
     * 
     * @param int $length
     * @return string
     */
    public static function generatePassword ($length = 8) {

        $password = '';

        srand( (double) microtime() * 1000000);
        $vowels = array("a", "e", "i", "o", "u");
        $cons = array("b", "c", "d", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "u", "v", "w", "tr", "cr", "br", "fr", "th", "dr", "ch", "ph", "wr", "st", "sp", "sw", "pr", "sl", "cl");
        $num_vowels = count($vowels);
        $num_cons = count($cons);

        for ($i = 0; $i < $length; $i++) {
            $password .= $cons[rand(0, $num_cons - 1)] . $vowels[rand(0, $num_vowels - 1)];
        }

        return (substr($password, 0, $length));

    }

}