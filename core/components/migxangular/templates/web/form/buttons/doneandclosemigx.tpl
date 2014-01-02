
<button type="button" ng-click = "onDoneCloseButtonClick({'closeonsuccess':true,'configs':'[[+request.configs]]','object_id':'[[+request.object_id]]','resource_id':'[[+request.resource_id]]','wctx':'[[+request.wctx]]','field':'[[+request.field]]','action':'mgr/migxdb/update','processaction':''})" class="btn btn-default" role="button" aria-disabled="false">
[[%save_and_close]]
</button>

<script>

    $scope.onDoneCloseButtonClick = function(params) {
        
        var data = angular.toJson($scope.data);
        
        if ($scope.parentscope.updateData[[+request.field_name]]($scope.data)){
            UiDialog.hideModal('[[+request.modal_id]]');    
        }         
        
        /*
        var cfg = Config;
        cfg.method = 'POST';
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.data = {
            data : data 
        };
        $http(ajaxConfig).success(function(response, status, header, config) {
            if (params.closeonsuccess){
                UiDialog.hideModal('[[+request.modal_id]]');
            }
        }).error(function(data, status, header, config) {
            UiDialog.error(data, status, header, config);
        });
        */
        
        //dialog.dialog('close');
    }
    
</script>        