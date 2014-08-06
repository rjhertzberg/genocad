<?php 
class Genocad_Controller_Plugin_Auth extends Zend_Controller_Plugin_Abstract
{
	/**
	 * @var Zend_Auth
	 */
	protected $_auth;	

	public function __construct(Zend_Auth $auth)
	{
		$this->_auth = $auth;
	}

	public function dispatchLoopStartup(Zend_Controller_Request_Abstract $request)
	{
		//Check if the user is not logged in
		if (!$this->_auth->hasIdentity())
		{
			return $this->_redirect($request, 'users', 'login', 'default');
		}

		//The user is logged in
		//Check if the authenticated user tries to access the users/login path
		if ('default' == $request->getModuleName()
			&& 'users' 		 == $request->getControllerName()
			&& 'login'		 == $request->getActionName())
		{
			return $this->_redirect($request, 'index', 'index', 'default');
		}
	}

	protected function _redirect($request, $controller, $action, $module)
	{
		if ($request->getControllerName() == $controller
			&& $request->getActionName()  == $action
			&& $request->getModuleName()  == $module)
		{
			return TRUE;
		}

		$url = Zend_Controller_Front::getInstance()->getBaseUrl();
		$url .= '/' . $controller
			 . '/' . $action;

	   //if (DEBUG)
	   //{
	   //    debug_redirect($url);
	   //}

	   return $this->_response->setRedirect($url);
	}
}
