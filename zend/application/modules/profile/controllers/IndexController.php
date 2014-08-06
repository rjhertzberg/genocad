<?php

class Profile_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */

    }

    public function indexAction()
    {
        $this->view->headTitle("GenoCAD: My Profile");
        $dbUsers = new Application_Model_DbTable_Users();
        $user = $dbUsers->find(Genocad_Application::getUser()->user_id)->current();
        $form = new Profile_Form_Profile();

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();

            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                $user->setFromArray(array_merge($user->toArray(), $form->getValues()))
                ->save();

                $this->_helper->redirector('index');

            }

        } else {

            $form->populate($user->toArray());
        }

        $form->submit->setLabel('Update Profile');
        $this->view->form = $form;
    }

    public function changePasswordAction()
    {
        $this->view->headTitle("GenoCAD: Change Password");
        $form = new Profile_Form_ChangePassword();

        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();

            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                $dbUsers = new Application_Model_DbTable_Users();
                $user = $dbUsers->find(Genocad_Application::getUser()->user_id)->current();

                // check to see if the user entered their current password correctly
                if (md5($data['password']) != $user->password) {
                    $form->setDescription('Current Password does not match our records. Please re-enter');
                } else if ($data['new_password'] != $data['confirm_password']) {
                    $form->setDescription('New Password does not match. Please re-enter');
                } else {
                    $user->setPassword($data['new_password']);
                    $this->view->status = 'Your password has been changed';
                    $this->_helper->redirector('index');
                }

            }
        }

        $this->view->form = $form;
    }

    public function resetPasswordAction()
    {
        $this->view->headTitle("GenoCAD: Reset Password");
        $form = new Profile_Form_ResetPassword();
        //$form->setDescription('testasdasd');
        $this->view->form = $form;

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();

            // check to see if the posted data passes the form validation
            if ($form->isValid($data)) {

                // Update the users password
                $dbUsers = new Application_Model_DbTable_Users();
                $user = $dbUsers->getUserByLogin($data['login']);
                $password = Genocad_Application::generatePassword();
                $user->setPassword($password);

                // get the email configuration information and send the email to the user
                $config = Zend_Registry::get('config')->email;

                $mail = new Zend_Mail();
                $mail->setBodyText('Your password has been reset to ' . $password);
                $mail->setFrom($config->from_address . '@' . $config->domain, $config->from_name);
                $mail->setReplyTo($config->from_address . '@' . $config->domain, $config->from_name);
                $mail->addTo($user->login, $user->first_name . ' ' . $user->last_name);
                $mail->setSubject('GenoCAD: Password Reset');
                $mail->addHeader('X-Mailer', 'PHP' . phpversion());
                $mail->send();

                $this->_helper->redirector('password-sent');

            }
        }
    }

    public function registerAction()
    {
        $this->view->headTitle("GenoCAD: Sign Up");
        $form = new Profile_Form_Profile();
        $form->login->addValidator(new Genocad_Validate_UniqueEmail(new Application_Model_DbTable_Users()));
        $form->submit->setLabel('Sign Up');

        // check to see if this is a post request, meaning the user submitted the form
        if ($this->getRequest()->isPost()) {

            $data = $this->getRequest()->getPost();

            // check to see if the posted data passes the form validation
            if (($form->isValid($data)) && ($form->getValue('my_url') == '')) {

                $dbUsers = new Application_Model_DbTable_Users();
                $user = $dbUsers->createRow($form->getValues());
                $password = Genocad_Application::generatePassword();
                $user->setPassword($password);
                $config = Zend_Registry::get('config')->website;

                // Need to send the user their password...
                $html = new Zend_View();
                $html->setScriptPath(APPLICATION_PATH . '/modules/profile/views/emails/');

                // assign valeues
                $html->assign('first_name', $user->first_name);
                $html->assign('last_name', $user->last_name);
                $html->assign('login', $user->login);
                $html->assign('password', $password);
                $html->assign('login_url', $this->getRequest()->getScheme() . '://' . $this->getRequest()->getHttpHost() . '/login');
                $html->assign('site', $config->name);

                // render view
                $bodyText = $html->render('signup.phtml');
                
                // get the email configuration information and send the email to the user
                $config = Zend_Registry::get('config')->email;

                $mail = new Zend_Mail();
                $mail->setBodyText($bodyText);
                $mail->setFrom($config->from_address . '@' . $config->domain, $config->from_name);
                $mail->setReplyTo($config->from_address . '@' . $config->domain, $config->from_name);
                $mail->addTo($user->login, $user->first_name . ' ' . $user->last_name);
                $mail->setSubject('GenoCAD: Thank You');
                $mail->addHeader('X-Mailer', 'PHP' . phpversion());
                $mail->send();

                // also need to send an email to the administrators so tat they 
                // can see a new sign-up was completed.

                // assign valeues
                $html->assign('user', $user);

                // render view
                $bodyText = $html->render('signup-notification.phtml');
                
                // configure base stuff
                $mail = new Zend_Mail();
                $mail->setBodyHtml($bodyText);
                $mail->setFrom($config->from_address . '@' . $config->domain, $config->from_name);
                $mail->setReplyTo($config->from_address . '@' . $config->domain, $config->from_name);
                $mail->setSubject('GenoCAD: Account Sign Up');
                $mail->addHeader('X-Mailer', 'PHP' . phpversion());
                foreach ($dbUsers->getAdminUsers() as $admin) {
                    $mail->addTo($admin->login, $admin->first_name . ' ' . $admin->last_name);
                }
                $mail->send();
                
                $this->_helper->redirector('thankyou');

            }

        }

        $this->view->form = $form;
    }

    public function passwordSentAction()
    {
        $this->view->headTitle("GenoCAD: Password Reset");
    }

    public function thankyouAction()
    {
        $this->view->headTitle("GenoCAD: Account Created");
    }


}











