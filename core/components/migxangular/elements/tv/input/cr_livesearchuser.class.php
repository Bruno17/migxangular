<?php

/**
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.input
 */
class modTemplateVarInputRenderLivesearchuser extends modTemplateVarInputRenderMigxFe {
    public function getTemplate() {
        return 'element/tv/renders/input/cr_livesearchuser.tpl';
    }
    
    public function process($value, array $params = array()) {
        //print_r($params);
        //{if $params.allowBlank == 1 || $params.allowBlank == 'true'}true{else}false{/if}
    }

}

return 'modTemplateVarInputRenderLivesearchuser';
