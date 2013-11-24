
<button type="button" ng-click = "onCancelButtonClick()"  class="btn btn-default" role="button" aria-disabled="false">
[[%cancel]]
</button>

<script>
    $scope.onCancelButtonClick = function(config) {
        UiDialog.hideModal('[[+request.modal_id]]');
    }
</script>