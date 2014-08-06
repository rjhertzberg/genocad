<?php

class Simulate_IndexController extends Zend_Controller_Action
{

    public function init()
    {
        $contextSwitch = $this->_helper->getHelper('contextSwitch');
        $contextSwitch->addActionContext('run', 'json')
                      ->initContext('json');

        $this->view->headTitle("GenoCAD: Simulate");

        //$auth = Zend_Auth::getInstance();
        //if (!$auth->hasIdentity()) {
        //    $this->_helper->redirector('index', 'login', 'default');
        //}
        
        $this->view->headScript()->appendFile('/js/dataTables-1.7/media/js/jquery.dataTables.js');
        $this->view->headScript()->appendFile('/js/dataTables.fnReloadAjax.js');
        $this->view->headScript()->appendFile('/js/simulation.js');
        $this->view->headScript()->appendFile('/js/tiptip/jquery.tipTip.js');
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_page.css');
        $this->view->headLink()->appendStylesheet('/js/dataTables-1.7/media/css/demo_table_jui.css');
        $this->view->headLink()->appendStylesheet('/js/tiptip/tipTip.css');
    }

    public function indexAction()
    {
        $dbDesigns = new Application_Model_DbTable_Designs();
        $this->view->designs = $dbDesigns->getSimulationDesigns();
        $this->view->publicDesigns = $dbDesigns->getSimulationDesigns(true);
    }

    public function simulateAction() {

        //$this->view->headScript()->appendFile('/flot/excanvas.min.js');
        //$this->view->headScript()->appendFile('/flot/jquery.flot.min.js');
        //$this->view->headScript()->appendFile('/flot/jquery.flot.selection.js');
        //$this->view->headScript()->appendFile('/flot/jquery.flot.axislabels.js');
        $this->view->headScript()->appendFile('/js/jqplot/excanvas.min.js');
        $this->view->headScript()->appendFile('/js/jqplot/jquery.jqplot.min.js');
        $this->view->headScript()->appendFile('/js/jqplot/plugins/jqplot.highlighter.min.js');
        $this->view->headScript()->appendFile('/js/jqplot/plugins/jqplot.cursor.min.js');
        $this->view->headScript()->appendFile('/js/jqplot/plugins/jqplot.canvasTextRenderer.min.js');
        $this->view->headScript()->appendFile('/js/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js');
        $this->view->headScript()->appendFile('/js/multiselect/jquery.multiselect.min.js');
        $this->view->headLink()->appendStylesheet('/js/multiselect/jquery.multiselect.css');
        $this->view->headLink()->appendStylesheet('/js/jqplot/jquery.jqplot.min.css');

        $dbDesigns = new Application_Model_DbTable_Designs();
        $this->view->design = $dbDesigns->find($this->_request->getParam('id'))->current();
        $this->view->max_intervals = Zend_Registry::get('config')->simulation->max_intervals;

    }

    public function runAction()
    {
        $this->_helper->layout()->disableLayout();

        // set the parameters
        $design_id = $this->_request->getParam('id');
        $duration = $this->_request->getParam('duration');
        $intervalLength = $this->_request->getParam('int_time');

        $result = Genocad_Utilities_Designs_Compiler::doAttributeCompilation($design_id);
        $report = Genocad_Utilities_Designs_Copasi::callCopasi($result['SBML'], $duration, $intervalLength);
        //$report = APPLICATION_PATH . '/modules/simulate/tmp/report.txt';
        
        // save the report file name in the session so it can be retrieved when 
        // attempting to download the file
        $simulationNamespace = new Zend_Session_Namespace('simulation');
        $simulationNamespace->reportFileName = $report; 

        $file = file ($report);

        // turn file into JSON series
        $series = array();

        foreach ($file as $lineKey => $line) {

            $cols = explode(chr(9), $line);
             
            foreach ($cols as $seriesKey => $col) {

            
                if ($lineKey == 0 && $seriesKey > 0) {
                    $series[]["label"] = substr($col, 0, strpos($col, '['));
                }
                 
                if ($lineKey > 0  && $seriesKey > 0) {
                    //$series[$seriesKey - 1]["data"][] = array($cols[0], $col);
                    
                    //$series[$seriesKey][] = array($cols[0], number_format($col));
                    $series[$seriesKey-1]["data"][] = array((float) $cols[0], (float) trim($col));
                }
                
            }
        }

        foreach ($series as $single) {
            $data[] = $single["data"];
            $labels[]["label"] = $single["label"];
        }
        //$data = $series;

        $this->view->data = $data;
        $this->view->series = $labels;

    }

    public function downloadAction()
    {
        $simulationNamespace = new Zend_Session_Namespace('simulation');
        $design_id = $this->_request->getParam('id');
        $type = $this->_request->getParam('type');

        switch($type) {
            case 'sbml':
                $result = Genocad_Utilities_Designs_Compiler::doAttributeCompilation($design_id);
                $file = $result['SBML'];
                $filename = 'sbml.xml';
                $contentType = 'text/xml';
                break;
            case 'code':
                $result = Genocad_Utilities_Designs_Compiler::doAttributeCompilation($design_id);
                $file = $result['Equations'];
                $filename = 'code.txt';
                $contentType = 'text/plain';
                break;
            case 'report':
                $file = $simulationNamespace->reportFileName;
                $filename = 'report.txt';
                $contentType = 'text/plain';
                break;
            default:
                break;
        }

        $this->view->file = $file;

        $this->_helper->layout()->disableLayout();
        $this->getResponse()
             ->setHeader('Content-Disposition', 'attachment; filename=' . $filename)
             ->setHeader('Content-type', $contentType);

    }
}
