
<button type="button" ng-click = "onLoadButtonClick({'configs':'childstutorial','object_id':'5','resource_id':'106','wctx':'web','field':'feld','action':'web/migxdb/fields','processaction':''})" class="btn btn-default" role="button" aria-disabled="false">
Load Child Dialog
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
        
        UiDialog.loadChildDialog($scope, Config, params, dialogOptions);   

    }    
</script>