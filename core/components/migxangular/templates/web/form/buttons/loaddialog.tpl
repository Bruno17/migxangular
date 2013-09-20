
<button type="button" ng-click = "onLoadButtonClick({'configs':'childstutorial','object_id':'5','resource_id':'106','wctx':'web','field':'feld','action':'web/migxdb/fields','processaction':''})" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Load Child Dialog</span>
</button>

<script>
    $scope.onLoadButtonClick = function(params) {
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
</script>