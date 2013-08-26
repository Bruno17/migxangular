
<div ng-controller="formCtrl[[+request.dialogCounter]]" class="ma-form">

<form>

<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">

<div class="ui-dialog-buttonset">
<button type="button" ng-click = "onButtonClick({'configs':'childstutorial','object_id':'5','resource_id':'106','wctx':'web','field':'feld','action':'web/migxdb/fields','processaction':''})" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Load Child Dialog</span>
</button>

<button type="button" ng-click = "onButtonClick2()" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Cancel</span>
</button>

<button type="button" ng-click = "onButtonClick3({'configs':'childstutorial','object_id':'2','resource_id':'2','wctx':'web','field':'feld','action':'mgr/migxdb/update','processaction':''})" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Save</span>
</button>

<button type="button" ng-click = "onButtonClick3({'closeonsuccess':true,'configs':'childstutorial','object_id':'2','resource_id':'2','wctx':'web','field':'feld','action':'mgr/migxdb/update','processaction':''})" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Save and Close</span>
</button>

</div>

</div>
<div >

<div data-ma-tabs id="tabs">
    <ul>
    [[+innerrows.tab]]
    </ul>
    [[+innerrows.tab_content]]
</div>


    
</div>

</form>
</div>


<script type="text/javascript">

function formCtrl[[+request.dialogCounter]]($scope, $http, $rootScope, Config, UiDialog){
    
    console.log($scope);
    
    $scope.onButtonClick2 = function(config) {
        console.log($scope);
        console.log(config);
        var dialog = $scope.dialogOptions.jquiDialog;
        dialog.dialog('close');
    }
    
    $scope.onButtonClick3 = function(params) {
        console.log($scope.data);
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
                dialog.dialog('close');                
            }
        }).error(function(data, status, header, config) {
            UiDialog.error(data, status, header, config);
        });
        
        //dialog.dialog('close');
    }    
    
    $scope.onButtonClick = function(params) {
        var dialogOptions = {
            callback: function() {
                if (dialogOptions.result !== undefined) {
                    cust.mncId = dialogOptions.result.whateverYouWant;
                }
            },
            result: {}
        };
        
        UiDialog.loadChildDialog($scope, Config, params, $rootScope, dialogOptions);   

    }    
     
}

</script>






