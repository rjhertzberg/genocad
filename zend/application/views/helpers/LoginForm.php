<?php
/**
 * LoginForm helper
 */
class Application_View_Helper_LoginForm
{
    public $view;

    public function setView(Zend_View_Interface $view)
    {
        $this->view = $view;
    }

    public function loginForm()
    {
        $str = <<<DEMO
            <h2>Sign-In</h2>  
            <div style="border: 1px solid green; padding-left: 10px; background-color: #FFFFDF; ">
            <form action="/login/process" method="post">
                <p>Username / Email:<br/><input type="text" name="username" size="23" value=""/></p>
                <p>Password:<br/><input type="password" name="password" size="23" value=""/></p>
                <p><input type="submit" value="Sign In"/></p>
            </form>
            <p><span style="font-weight:bold;">Don't have an Account?</span> <a href="/profile/register">Register</a></p>
            </div>
DEMO;

         return $str;

    }

}