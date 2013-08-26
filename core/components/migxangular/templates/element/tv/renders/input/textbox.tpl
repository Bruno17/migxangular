<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]
</label>
<input class="form-control" ng-change="onChange()" ng-model="data.[[+tv.fieldname]]" id="tv[[+tv.id]]" name="tv[[+tv.id]]" type="text" />
</div>

<script type="text/javascript">
    console.log('[[+tv.id]]');

</script>