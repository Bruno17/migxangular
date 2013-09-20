
<button type="button" ng-click = "onCancelButtonClick()" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Cancel</span>
</button>

<script>
    $scope.onCancelButtonClick = function(config) {
        console.log($scope);
        console.log(config);
        var dialog = $scope.dialogOptions.jquiDialog;
        dialog.dialog('close');
    }
</script>