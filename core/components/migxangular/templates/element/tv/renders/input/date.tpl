<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]
</label>

    <div class="input-group">
        <span class="input-group-addon glyphicon glyphicon-calendar"></span>
        <input type="text" id="tv[[+tv.id]]" class="form-control" ng-model="data.[[+tv.fieldname]]" datetimepicker />
        <span class="input-group-addon glyphicon glyphicon-question-sign"></span>
    </div>


</div>

<script type="text/javascript">
    //console.log('[[+tv.id]]');
</script>

<script>
    
    $scope.onClick[[+tv.fieldname]] = function(){
        //console.log($scope.data.[[+tv.fieldname]]);
    }
    

</script>