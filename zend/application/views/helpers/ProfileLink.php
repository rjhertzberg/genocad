<?php
/**
 * ProfileLink helper
 *
 * Call as $this>>profileLink() in your layout script
 */
class Application_View_Helper_ProfileLink
{
    public $view;

    public function setView(Zend_View_Interface $view)
    {
        $this->view = $view;
    }

    public function profileLink()
    {

        $links = Array();
        $request = Zend_Controller_Front::getInstance()->getRequest();

        if (Genocad_Application::isLoggedIn()) {

            $user = Genocad_Application::getUser();
            $url = '/login/logout';
            $text = 'Log Out';
            $html = sprintf('<p style="text-align: right;">Welcome, %s %s&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/profile/">My Profile</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="%s">%s</a></p>', $user->first_name, $user->last_name, $url, $text);

            $links["my-parts"] = "/parts/?tab=myparts";
            $links["my-libraries"] = "/parts/?tab=mylibraries";


        } else {

            $url = '/login';
            $text = 'Log In';
            $html = sprintf('<p style="text-align: right;">Welcome, Guest&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/profile/index/register/">Sign Up</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="%s">%s</a></p>', $url, $text);

            $links["my-parts"] = "/login?reqlogin=My Parts&refurl=/parts/?tab=myparts";
            $links["my-libraries"] = "/login?reqlogin=My Libraries&refurl=/parts/?tab=mylibraries";
            //$links["my-libraries"] = "/parts/?tab=mylibraries";

        }

        $links["my-designs"] = "/design/index/my-designs";
        
        //check for help file existence
        $module = $request->getModuleName();
        $controller = $request->getControllerName();
        $action = $request->getActionName();

        $help_exists = file_exists(APPLICATION_PATH . '/../public/help-files/' . $module . '-' . $controller . '-' . $action  . '.html');
        
        $html .= '<div style="text-align: right; padding-top: 5px;">';
        $html .= '<a href="' . $links["my-parts"] .'" alt="My Parts"><img valign="absmiddle" src="/images/other/my-parts.png" title="My Parts" /></a>';
        $html .= '<a href="' . $links["my-libraries"] .'" alt="My Libraries"><img valign="absmiddle" src="/images/other/my-libraries.png" title="My Libraries" /></a>';
        $html .= '<a href="' . $links["my-designs"] .'" alt="Available Designs"><img valign="absmiddle" src="/images/other/my-designs.png" title="Available Designs" /></a>';
        $html .= '<a href="/search" alt="Search Parts"><img valign="absmiddle" src="/images/other/search.png" title="Search Parts" /></a>';
        
        if ($help_exists) {
            $html .= sprintf('<a href="javascript:load_help(\'%s\',\'%s\',\'%s\');" alt="Help"><img valign="absmiddle" src="/images/other/help.png" title="Help" /></a>', $module, $controller, $action);
        } else {
            $html .= sprintf('<a href="javascript:load_help(\'%s\',\'%s\',\'%s\');" alt="Help"><img valign="absmiddle" src="/images/other/nohelp.png" title="Help" /></a>', $module, $controller, $action);
        }

        $html .= '</div>';

        return ($html);

    }
}