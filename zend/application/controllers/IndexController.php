<?php

class IndexController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
    }

    public function indexAction()
    {
        // For now, the home page is the Parts Browser, so redirect to that page
        //$this->_helper->getHelper('Redirector')->gotoSimple('index', 'index', 'parts');
        $this->view->headTitle("GenoCAD: CAD Software for Synthetic Biology");
    }

    public function aboutAction()
    {
        $this->view->headTitle("GenoCAD: CAD Software for Synthetic Biology");
    }

    public function privacyAction()
    {
        $this->view->headTitle("GenoCAD: Privacy Policy");
    }

    public function documentsAction()
    {
        $this->view->headTitle("GenoCAD: Documentation and Tutorials");
    }

    public function supportAction()
    {
        $this->view->headTitle("GenoCAD: Support and Feedback");
        $form = new Application_Form_Contact;
        $this->view->form = $form;

        if ($this->getRequest()->isPost()) {
            if (($form->isValid($this->getRequest()->getPost())) && ($form->getValue('my_url') == '')) {

                $dbUsers = new Application_Model_DbTable_Users();

                $html = new Zend_View();
                $html->setScriptPath(APPLICATION_PATH . '/views/emails/');
                
                // Get config value for feedback message
                $config = Zend_Registry::get('config')->website;

                // assign valeues
                $html->assign('email', $form->getValue('email'));
                $html->assign('subject', $form->getValue('subject'));
                $html->assign('message', $form->getValue('message'));
                $html->assign('site', $config->name);

                // render view
                $bodyText = $html->render('feedback.phtml');

                // get the email configuration information and send the email to the user
                $config = Zend_Registry::get('config')->email;

                $mail = new Zend_Mail('utf-8');
                $mail->setBodyHtml($bodyText);
                $mail->setFrom($config->from_address . '@' . $config->domain, $config->from_name);
                $mail->setReplyTo($config->from_address . '@' . $config->domain, $config->from_name);
                foreach ($dbUsers->getAdminUsers() as $admin) {
                    $mail->addTo($admin->login, $admin->first_name . ' ' . $admin->last_name);
                }
                $mail->setSubject('GenoCAD: Feedback');
                $mail->addHeader('X-Mailer', 'PHP' . phpversion());
                $mail->send();

                $this->_helper->redirector('feedback-sent');
            }
        }
    }

    public function feedbackSentAction()
    {
        $dbUsers = new Application_Model_DbTable_Users();
        $users = $dbUsers->getAdminUsers();
        $this->view->headTitle("GenoCAD: Feedback Thanks");
    }

    public function termsAction()
    {
        $this->view->headTitle("GenoCAD: Terms and Conditions");
    }


}









