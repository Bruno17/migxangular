<button type="button" ng-click = "onDoneCloseButtonClick({'closeonsuccess':true,'configs':'[[+request.configs]]','object_id':'[[+request.object_id]]','resource_id':'[[+request.resource_id]]','wctx':'[[+request.wctx]]','field':'[[+request.field]]','action':'mgr/migxdb/update','processaction':''})" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Speichern und Schließen</span>
</button>

<script>

    $scope.onDoneCloseButtonClick = function(params) {

        var dialog = $scope.dialogOptions.jquiDialog;
        var cfg = Config;
        cfg.method = 'POST';
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.data = {
            data : angular.toJson($scope.data) 
        };
        $http(ajaxConfig).success(function(response, status, header, config) {
            if (params.closeonsuccess){
                var dialog = $scope.dialogOptions.jquiDialog;
                if (response.success){
                    var object = response.object || {};
                    var price = object.price || 0;
                    var comment = object.comment || '';

                    dialog.dialog('close'); 

                    if (object){
                        $scope.reservable.price = price;
                        $scope.reservable.comment = comment;
                    }
                    
                    $scope.refreshBooking();                       
                }
             
            }
        }).error(function(data, status, header, config) {
            UiDialog.error(data, status, header, config);
        });
        
        //dialog.dialog('close');
    }
    
</script>        