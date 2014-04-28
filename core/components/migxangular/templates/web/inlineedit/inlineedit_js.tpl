jQuery(document).ready(function() {

// We need to turn off the automatic editor creation first.
CKEDITOR.disableAutoInline = true;

ma_mainController = $('#ma-maintoolbarCtrl').scope();

    
ma_mainController.updateInline = function(params,value) {
    //console.log($(this).html());
    //console.log(ma_mainController);
    
    var UiDialog = ma_mainController.UiDialog;
    var cfg = ma_mainController.config;
    var params = params;
    params['action'] = 'mgr/migxdb/update';
    params['configs'] = 'mub_createupdate';
    var data = {};
    data[params.field] = value;
    
    UiDialog.showPleaseWait();
    cfg.method = 'POST';
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.data = {
            data : angular.toJson(data) 
        };
        ma_mainController.http(ajaxConfig).success(function(response, status, header, config) {
             UiDialog.hidePleaseWait();
        }).error(function(data, status, header, config) {
            UiDialog.error(data, status, header, config);
        });    
    
}; 

    
});
