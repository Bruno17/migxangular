<?php

/**
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.input
 */
class modTemplateVarInputRenderLivesearchBooking extends modTemplateVarInputRenderMigxFe {
    public function getTemplate() {
        return 'element/tv/renders/input/cr_livesearchbooking.tpl';
    }
    
    public function process($value, array $params = array()) {
        //print_r($params);
        //{if $params.allowBlank == 1 || $params.allowBlank == 'true'}true{else}false{/if}
        $bookingtypes = array();
        $c = $this->modx->newQuery('crBookingType');
        $c->sortby('name');
        if ($collection = $this->modx->getCollection('crBookingType',$c)){
            $bookingtype = array('alias'=>'','name'=>'--Alle--');
            $bookingtypes[] = $bookingtype;
            foreach ($collection as $object){
                $bookingtypes[] = $object->toArray();
            }
        }        
        
        $this->setPlaceholder('bookingtypes', $this->modx->toJson($bookingtypes));

    }        
        
    

}

return 'modTemplateVarInputRenderLivesearchBooking';
