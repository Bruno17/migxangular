<?php
/**
 * @package modx
 * @subpackage processors.element.tv.renders.mgr.input
 */
class modTemplateVarInputRenderDate extends modTemplateVarInputRenderMigxFe {
    public function process($value,array $params = array()) {
        $v = $value;
        if ($v != '' && $v != '0' && $v != '0000-00-00 00:00:00') {
            $v = strftime('%Y-%m-%d %H:%M:%S',strtotime($v));
        }
        $this->tv->set('value',$v);

        if (!empty($params['disabledDates'])) {
            $params['disabledDates'] = $this->modx->toJSON(explode(',',$params['disabledDates']));
        }
        if (!empty($params['disabledDays'])) {
            $params['disabledDays'] = $this->modx->toJSON(explode(',',$params['disabledDays']));
        }
        $this->setPlaceholder('params',$params);
        $this->setPlaceholder('tv',$this->tv->toArray());
        $this->setPlaceholder('maxview','data-max-view="0"');//only date, close calendar after date-click
    }
    public function getTemplate() {
        return 'element/tv/renders/input/date.tpl';
    }
}
return 'modTemplateVarInputRenderDate';