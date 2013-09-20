<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]
</label>

<div ng-repeat="option in options.[[+tv.fieldname]]">
      <input
        type="checkbox"
        value="{{option.value}}"
        ng-checked="option.checked"
        ng-model="option.checked"
        ng-change="onChange[[+tv.fieldname]]()"
      />
      
      <span>{{option.text}}</span>
<br />
</div>


</div>

<script>

    $scope.options = $scope.options || {};
    $scope.options.[[+tv.fieldname]] = angular.fromJson('[[+inputoptions]]');
    
    $scope.getselected[[+tv.fieldname]] = function () {
        return $filter('filter')($scope.options.[[+tv.fieldname]], {checked: true});
    };
    
    $scope.onChange[[+tv.fieldname]] = function(){
        var selected = $scope.getselected[[+tv.fieldname]](); 
        var items = [];
        for (var i = 0; i < selected.length; i++){
            items.push(selected[i].value);
        }
        
        $scope.data.[[+tv.fieldname]] = items;  

    };
    
  

</script>