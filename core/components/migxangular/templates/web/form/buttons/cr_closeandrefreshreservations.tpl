<button type="button" ng-click = "onCloseRefreshButtonClick()" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Schließen und Aktualisieren</span>
</button>

<script>
    $scope.onCloseRefreshButtonClick = function(config) {
        var dialog = $scope.dialogOptions.jquiDialog;
        dialog.dialog('close');
        $scope.changeDate();
    }
</script>