<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]
</label>

<select class="form-control" id="tv[[+tv.id]]" name="tv[[+tv.id]]" ng-model="data.[[+tv.fieldname]]" ng-options="i.value as i.text for i in options.[[+tv.fieldname]]"></select>

</div>

<script>

    $scope.options = $scope.options || {};
    $scope.options.[[+tv.fieldname]] = angular.fromJson('[[+inputoptions]]');

</script>