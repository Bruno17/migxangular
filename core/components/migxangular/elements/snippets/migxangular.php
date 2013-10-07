<?php

$migxangular = $modx->getService('migxangular', 'MigxAngular', $modx->getOption('migxangular.core_path', null, $modx->getOption('core_path') . 'components/migxangular/') . 'model/migxangular/', $scriptProperties);
if (!($migxangular instanceof MigxAngular))
    return '';

//Add needed js-files to the head

$properties = array();
//$properties['auth']=$_SESSION["modx.{$modx->context->get('key')}.user.token"];


$buttons = $modx->getOption('buttons', $scriptProperties, '');

if (!empty($buttons)) {
    $buttons = $modx->fromJson($buttons);
} else {
    $buttons = array(array('configs' => 'childstutorial', 'text' => 'Edit Resource ' . $modx->resource->get('id')));
}



$buttonsoutput = array();
if (!empty($buttons)) {
    if (is_array($buttons)) {
        foreach ($buttons as $button) {
            $permission = $modx->getOption('permission', $button, '');
            if (!empty($permission)){
                if ($modx->hasPermission($permission)){
                    
                }else{
                    continue;
                }
            } 
            
            $prop['extraparams'] = '';
            $extraparams = $modx->getOption('extraparams', $button, '');
            if (is_array($extraparams) && count($extraparams) > 0) {
                foreach ($extraparams as $key => $value) {
                    $params[] = "'" . $key . "':'" . $value . "'";
                }
                $prop['extraparams'] = ',' . implode(',', $params);
            }

            $prop['id'] = $modx->getOption('id', $button, '');
            $prop['text'] = $modx->getOption('text', $button, '');
            $prop['iconCls'] = $modx->getOption('iconCls', $button, '');
            $prop['configs'] = $modx->getOption('configs', $button, 'childstutorial');
            $prop['resource_id'] = $modx->getOption('resource_id', $button, $modx->resource->get('id'));
            $prop['object_id'] = $modx->getOption('object_id', $button, $modx->resource->get('id'));
            $prop['wctx'] = $modx->getOption('wctx', $button, $modx->resource->get('context_key'));
            $prop['field'] = $modx->getOption('field', $button, '');
            $prop['action'] = $modx->getOption('action', $button, 'web/migxdb/fields');
            $prop['processaction'] = $modx->getOption('processaction', $button, '');
            $prop['win_title'] = $modx->getOption('win_title', $button, ''); //Todo: get it from configs
            $prop['handler'] = $modx->getOption('handler', $button, 'onButtonClick');
            $templatePath = $migxangular->config['templatesPath'] . 'web/button.tpl';
            $buttonsoutput[] = $migxangular->parseChunk($templatePath, $prop);
        }
    }
}

$properties['customhandlers'] = $modx->getOption('customhandlers', $scriptProperties, '');
$properties['buttons'] = implode('', $buttonsoutput);
$properties['auth'] = $_SESSION["modx.mgr.user.token"];
$properties['resource_id'] = $modx->resource->get('id');
$properties['wctx'] = $modx->getOption('wctx', $scriptProperties, $modx->resource->get('context_key'));
$properties['request_uri'] = $_SERVER["REQUEST_URI"];

/*
$properties['buttons']= '
{
id: 'show-btn',
text: 'Users',
iconCls: 'user',
data: {
'configs':'childstutorial',
'object_id':'27',
'resource_id':'[[+resource_id]]',
'wctx':'[[+wctx]]',
'field':'',
'action':'web/fields',
'processaction':'',
'win_id':'win-migxangular-test',
'win_title':'Test Window'
},
handler: this.onButtonClick
},{
id: 'show-btn2',
text: 'Users2',
iconCls: 'user2',
data: {
'configs':'childstutorial',
'object_id':'28',
'resource_id':'[[+resource_id]]',
'wctx':'[[+wctx]]',
'field':'',
'action':'web/fields',
'processaction':'',
'win_id':'win-migxangular-test2',
'win_title':'Test Window 2'
},
handler: this.onButtonClick
}
';
*/

$templatePath = $migxangular->config['templatesPath'] . 'web/toolbar.tpl';
$toolbar = $migxangular->parseChunk($templatePath, $properties);

//$modx->regClientCSS('assets/components/migxangular/js/ext4/resources/css/ext-all.css');
//$modx->regClientCSS('assets/components/migxangular/js/ext4/resources/css/ext-all-gray.css');
//$modx->regClientCSS('assets/components/migxangular/css/reset.css');
//$modx->regClientStartupScript('assets/components/migxangular/js/ext4/ext-all.js');

$modx->regClientCSS('http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css');
$modx->regClientStartupScript('http://code.jquery.com/jquery-1.9.1.js');
$modx->regClientStartupScript('http://code.jquery.com/ui/1.10.3/jquery-ui.js');


$modx->regClientStartupScript('assets/components/courtreservation/js/jquery-ui/i18n/jquery.ui.datepicker-de.js');


//$modx->regClientStartupScript('assets/components/migxangular/js/angular.js');
$modx->regClientStartupScript('https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0rc1/angular.min.js');
$modx->regClientStartupScript('http://code.angularjs.org/1.2.0rc1/angular-animate.min.js');


$modx->regClientStartupScript('assets/components/migxangular/js/sanitize.js');
$modx->regClientStartupScript('assets/components/migxangular/js/sprintf.js');
$modx->regClientStartupScript('assets/components/migxangular/js/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js');


$modx->regClientCSS('assets/components/migxangular/bootstrap-3.0.0/css/bootstrap.custom.css');
$modx->regClientCSS('assets/components/migxangular/js/bootstrap-datetimepicker/css/datetimepicker.css');
$modx->regClientCSS('assets/components/migxangular/css/migxangular.css');

//$modx->regClientCSS('assets/components/migxangular/ui-bootstrap/css/bootstrap.min.css');
//$modx->regClientCSS('assets/components/migxangular/ui-bootstrap/css/jquery-ui-1.10.3.custom.css');

//$modx->regClientStartupScript('assets/components/migxangular/js/ext4/ext-debug.js');
//$modx->regClientStartupScript('assets/components/migxangular/js/ext4/ext-theme-gray.js');
//$modx->regClientStartupScript('assets/components/migxangular/js/xtypes/datetime.js');

$scriptPath = $migxangular->config['templatesPath'] . 'web/app_js.tpl';
$script = $migxangular->parseChunk($scriptPath, $properties);

$script = '<script type="text/javascript" charset="utf-8">' . $script . '</script>';

$modx->regClientStartupScript($script);
//directives
//$modx->regClientStartupScript('assets/components/migxangular/js/directives/typeahead.js');
$modx->regClientStartupScript('assets/components/migxangular/js/directives/datetimepicker.js');

return $toolbar;
