<?php

class LoginController extends Zend_Controller_Action
{

    public function init()
    {
        $this->view->headTitle("GenoCAD: Log In");
    }
    
    public function getForm() {
        return new Application_Form_Login(array(
            'action' => '/login/process',
            'method' => 'post',
        ));
    }

    public function getAuthAdapter(array $params)
    {
        // Leaving this to the developer...
        // Makes the assumption that the constructor takes an array of
        // parameters which it then uses as credentials to verify identity.
        // Our form, of course, will just pass the parameters 'username'
        // and 'password'.
        $authAdapter = new Zend_Auth_Adapter_DbTable(
            //Zend_Db::factory(Zend_Registry::get('config')->resources->db),
            Zend_Db_table_abstract::getDefaultAdapter(),
            'users',
            'login',
            'password'
        );
        $authAdapter->setIdentity($params['username']);
        $authAdapter->setCredential($params['password']);
        $authAdapter->setCredentialTreatment('MD5(?)');
        return ($authAdapter);
    }

    public function preDispatch()
    {
        if (Zend_Auth::getInstance()->hasIdentity()) {
            // If the user is logged in, we don't want to show the login form;
            // however, the logout action should still be available
            if ('logout' != $this->getRequest()->getActionName()) {
                $this->_helper->redirector('index', 'index');
            }
        } else {
            // If they aren't, they can't logout, so that action should
            // redirect to the login form
            if ('logout' == $this->getRequest()->getActionName()) {
                $this->_helper->redirector('index');
            }
        }
    }

    public function indexAction()
    {
        $form = $this->getForm();
        $form->refurl->setValue($this->getRequest()->getParam('refurl'));
        $reqlogin = $this->getRequest()->getParam('reqlogin', '');
        if ($reqlogin != '') {
            $form->setDescription("Please log in to access the ".$reqlogin." tab.");
        }

        $this->view->form = $form;
    }

    public function processAction()
    {

        $request = $this->getRequest();
        $valid = false;
        $invalid_message = '';

        // Check if we have a POST request
        if (!$request->isPost()) {
            return $this->_helper->redirector('index');
        }

        // Get our form and validate it
        $form = $this->getForm();
        if (!$form->isValid($request->getPost())) {
            // Invalid entries
            $this->view->form = $form;
            return $this->render('index'); // re-render the login form
        }

        // Get our authentication adapter and check credentials
        $adapter = $this->getAuthAdapter($form->getValues());
        $auth    = Zend_Auth::getInstance();
        $result  = $auth->authenticate($adapter);

        // check the result of the authentication
        if (!$result->isValid()) {
            // the authentication has failed because the user did not provide
            // the proper credentials
            $invalid_message = 'Username or Password is incorrect.';
        } else {

            // We're authenticated!
            $dbUsers = new Application_Model_DbTable_Users();
            $user = $dbUsers->getUserByLogin($form->getValue('username'));

            // need to check the status of the user account
            if ($user->approved_flag == '0') {
                $invalid_message = 'This User Account is currently under review.';
            } else if ($user->approved_flag == '-1') {
                $invalid_message = 'The request for this User Account has been denied.';
            } else {
                $valid = true;
            }

        }

        // Set some session level variables

        
        if (!$valid) {
            $form->setDescription($invalid_message);
            $this->view->form = $form;
            Zend_Auth::getInstance()->clearIdentity();
            return $this->render('index'); // re-render the login form
        } else {
            // store the user
            Zend_Auth::getInstance()->getStorage()->write($user);
            //Redirect to the home page
            if ($this->getRequest()->getParam('refurl') != null) {
                $this->_helper->getHelper('Redirector')->gotoUrl(urldecode($this->getRequest()->getParam('refurl')));
            } else {
                $this->_helper->getHelper('Redirector')->gotoSimple('index', 'index');    
            }

        }

    }

    public function logoutAction()
    {
        Zend_Auth::getInstance()->clearIdentity();
        $this->_helper->redirector('index'); // back to login page
    }


}

