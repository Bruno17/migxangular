<?php

/**
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.input
 */
class modTemplateVarInputRenderReservableGrid extends modTemplateVarInputRenderMigxFe {
    public function getTemplate() {
        return 'element/tv/renders/input/cr_reservablegrid.tpl';
    }
    
    public function process($value, array $params = array()) {
        //print_r($params);
        //{if $params.allowBlank == 1 || $params.allowBlank == 'true'}true{else}false{/if}
        $coaches = array();
        $c = $this->modx->newQuery('crCoach');
        $c->sortby('fullname');
        if ($collection = $this->modx->getCollection('crCoach',$c)){
            $coach = array('id'=>0,'fullname'=>'--Alle--');
            $coaches[] = $coach;
            foreach ($collection as $object){
                $coaches[] = $object->toArray();
            }
        }
        
        $categories = array();
        $c = $this->modx->newQuery('crCourtCategory');
        $c->sortby('name');
        if ($collection = $this->modx->getCollection('crCourtCategory',$c)){
            $category = array('id'=>0,'name'=>'----');
            $categories[] = $category;
            foreach ($collection as $object){
                $categories[] = $object->toArray();
            }
        }        
        
        $this->setPlaceholder('coaches', $this->modx->toJson($coaches));
        $this->setPlaceholder('courtcategories', $this->modx->toJson($categories));
    }

}

return 'modTemplateVarInputRenderReservableGrid';
