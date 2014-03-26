<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]

</label>
    <div class="input-group">
        <input class="form-control" ng-change="onChange()" ng-model="data.[[+tv.fieldname]]" id="tv[[+tv.id]]" name="tv[[+tv.id]]" type="text" />
        <span class="input-group-addon glyphicon glyphicon-question-sign"></span>
    </div>
    
    <div class="btn-group migx_grid_toolbar">
    <button type="button" class="btn btn-default" ng-click="addItem[[+tv.fieldname]]()" >[[%migx.add]]</button>    
    
    </div>   
    
    <table class="table">
    <thead>
    <tr>
    <th ng-repeat="column in columns.[[+tv.fieldname]]" width="{{column.width}}" >{{column.header}}</th>
    </tr>
    </thead>
    <tbody ui-sortable="sortableOptions[[+tv.fieldname]]" ng-model="items.[[+tv.fieldname]]">
    <tr ng-clickX="onRowMouseDown[[+tv.fieldname]]()"  ng-repeat="item in items.[[+tv.fieldname]]">
    <td ng-click="onClick[[+tv.fieldname]]($event)" ng-repeat="column in item.MIGX_columns" >
    <div ng-bind-html="column.html"></div>
    </td>
    </tr>
    </tbody>
    </table>
    
</div>

<script>

    

    $scope.sortableOptions[[+tv.fieldname]] = {
        stop: function(e, ui) {
            $scope.data.[[+tv.fieldname]] = angular.toJson($scope.items.[[+tv.fieldname]]);    
        },
        axis: 'y'        
    }

    $scope.onRowMouseDown[[+tv.fieldname]] = function(e){
        //console.log(this);
    }
    

    $scope.onCellMouseDown[[+tv.fieldname]] = function(e){
        //console.log(e);
    }    
    
    $scope.onClick[[+tv.fieldname]] = function(e){
        
        var t = e.target;
        var elm = t.className.split(' ')[0];
		if(elm == 'controlBtn') {
            var handler = t.className.split(' ')[2];
            var col =  t.className.split(' ')[3];
            //var col = null;
            var fieldname = '[[+tv.fieldname]]';
            //var handler = this.button.handler;
            handler = '$scope.' + handler.replace('this.','') + fieldname;
            var fn = eval(handler);
            //fn = fn.createDelegate(this);
            fn(this,null,e,col);   
        }
    }
    
    $scope.remove[[+tv.fieldname]] = function(that){
        var index = that.$parent.$index;
        $scope.items.[[+tv.fieldname]].splice(index, 1);  
        $scope.data.[[+tv.fieldname]] = angular.toJson($scope.items.[[+tv.fieldname]]);      
    }
    
    $scope.update[[+tv.fieldname]] = function(that,xxx,e,col){
        var btn = null;
        var e = null;  
        $scope.action[[+tv.fieldname]] = 'u';
        $scope.index[[+tv.fieldname]] = that.$parent.$index;         
        $scope.loadWin[[+tv.fieldname]](btn,e);   
    }
    
    $scope.addItem[[+tv.fieldname]] = function(){
	    var maxRecords =  parseInt('[[+customconfigs.maxRecords]]');
        var btn = null;
        var e = null;
        //var s=this.getStore();
        var count = $scope.items.[[+tv.fieldname]].length;
        if(maxRecords != 0 && count >= maxRecords){
            alert ('[[%migx.max_records_alert]]');
            return;            
        }
        $scope.action[[+tv.fieldname]] = 'a';
        $scope.index[[+tv.fieldname]] = count;        
		$scope.loadWin[[+tv.fieldname]](btn,e);        
    }

    $scope.loadWin[[+tv.fieldname]] = function(btn,e){
        var cfg = Config;
        cfg.method = 'POST';
        
        var action = $scope.action[[+tv.fieldname]];
        var index = $scope.index[[+tv.fieldname]];
        
	    var resource_id = '[[+resource.id]]';
        var co_id = '[[+connected_object_id]]';
        var object_id = '[[+request.object_id]]';
        //var input_prefix = Ext.id(null,'inp_');
        [[+properties.autoResourceFolders:is=`true`:then=`
        if (resource_id == 0){
            alert ('[[%migx.save_resource]]');
            return;
        }        
        `:else=``]]
        
        if (action == 'a'){
           var json='[[+newitem]]';
           var data=angular.fromJson(json);
        }else{
           var data = $scope.items.[[+tv.fieldname]][index];
           $scope.currentItem[[+tv.fieldname]] = data;   
           var json = angular.toJson(data);
        }
        
        var isnew = (action == 'u') ? '0':'1'; 

        var params = {
				record_json:json,
			    action: 'web/migx/fields',
				tv_id: '[[+tv.id]]',
				tv_name: '[[+tv.name]]',
                field_name: '[[+tv.fieldname]]',
                configs: '[[+properties.configs]]',
				'class_key': 'modDocument',
                'wctx':'[[+myctx]]',
				itemid : index,
                autoinc : $scope.autoinc[[+tv.fieldname]],
                isnew : isnew,
                resource_id : resource_id,
                object_id: object_id,
                co_id : co_id,
                //input_prefix: input_prefix
        }
        
        //params.action = 'web/migxdb/fields';

        /*
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.data = {
            data : angular.toJson($scope.data),
            bookingdata : angular.toJson($scope.bookingdata)
        };
        */
        var postData = {
            data : angular.toJson($scope.data)
        };
        var dialogOptions = {
            id : 'Level2',
            contentPreSize : "lg" //df,sm,md,lg,fl;  
        };

        UiDialog.loadChildDialog($scope, Config, params, dialogOptions, postData);
    }
    
    $scope.updateData[[+tv.fieldname]] = function(data){
        
        var action = $scope.action[[+tv.fieldname]];
        var index = $scope.index[[+tv.fieldname]];
        var columns = $scope.columns.[[+tv.fieldname]];        

        //$scope.items.[[+tv.fieldname]];
        data['MIGX_id'] = $scope.autoinc[[+tv.fieldname]];
        $scope.autoinc[[+tv.fieldname]] = data['MIGX_id'] + 1;
        data.MIGX_columns = $scope.renderCells[[+tv.fieldname]](data,columns);
        
        if (action == 'u'){
            //update item
            data['MIGX_id'] = $scope.currentItem[[+tv.fieldname]]['MIGX_id'];
            $scope.items.[[+tv.fieldname]][index] = data;
        }else{
            //add new item
            $scope.items.[[+tv.fieldname]].push(data);    
        }
        
        $scope.data.[[+tv.fieldname]] = angular.toJson($scope.items.[[+tv.fieldname]]);
        
        return true;
        
    }    
    

    $scope.loadData[[+tv.fieldname]] = function(){
	    var items_string = $scope.data.[[+tv.fieldname]];
        var columns = $scope.columns.[[+tv.fieldname]];
        var items = [];
        var item = {};
        var i = 0;
        try {
            items = angular.fromJson(items_string);
        }
        catch (e){
        }
                
        $scope.autoinc[[+tv.fieldname]] = 1;
        for(i = 0; i <  items.length; i++) {
 		    item = items[i];
            if (item.MIGX_id){
                if (parseInt(item.MIGX_id)  >= $scope.autoinc[[+tv.fieldname]]){
                    $scope.autoinc[[+tv.fieldname]] = item.MIGX_id +1;
                }
            }else{
                item.MIGX_id = $scope.autoinc[[+tv.fieldname]] +1 ;
                $scope.autoinc[[+tv.fieldname]] = item.MIGX_id +1;                 
            }
           //item.html = $scope.renderCell[[+tv.fieldname]](item); 	
           //console.log($scope.columns.[[+tv.fieldname]]);
           item.MIGX_columns = $scope.renderCells[[+tv.fieldname]](item,columns); 
           items[i] = item;  
        } 
        $scope.items.[[+tv.fieldname]] = items;
        
    }
    
    $scope.renderCells[[+tv.fieldname]] = function(item,columns){

        var cells = [];
        var cell = null;
        var i = 0;
        for(i = 0; i < columns.length; i++){
            cell = $scope.renderCell[[+tv.fieldname]](item,columns[i],i);
            cells.push(cell);     
        }
        
        return cells;    
    }
    
    $scope.renderCell[[+tv.fieldname]] = function(item,column,colIndex){
        var fieldname = '[[+tv.fieldname]]';
        var dataIndex = column.dataIndex;
        var value = item[dataIndex] || '';
        var renderer = column.renderer || false;
        //var buttons = [{'text':'entfernen','handler':'delete'},{'text':'bearbeiten','handler':'edit'},{'text':value,'handler':'testhandler'},{'text':'c','handler':'testhandler'}];
       
        var html = value;
        
        if (renderer) {
            var handler = renderer;
            handler = '$scope.' + handler.replace('this.','') + fieldname;
            
            var fn = eval(handler);
            //fn = fn.createDelegate(this);
            if (typeof (fn) == 'function'){
               html = fn(value,item,colIndex); 
            }
        }
       
        var cell = {
            html: $sce.trustAsHtml(html) 
        } 
        
        return cell;
    }
    
    $scope.renderRowActions[[+tv.fieldname]] = function(v,item) {
        var n = item;
        var m = [];	   
        [[+customconfigs.gridcolumnbuttons]]
        var i = 0;
        //var buttons = [];
        var buttons = '<h3 class="main-column">' + v + '</h3>'; 
        //buttons += '<ul class="actions">';
        var button = null;
        for(i = 0; i < m.length; i++){
            button = m[i];
            if (typeof (button.className) != 'undefined' && typeof (button.handler) != 'undefined'){
                //button.handler = button.handler.replace('.this', '');
                //buttons.push(button); 
                buttons += '<button type="button" class="controlBtn ' + button.className + ' ' + button.handler + ' btn btn-default" >' + button.text + '</button>  ';                   
            }            
        }
        
        //buttons += '</ul>';
        return buttons;
	}
    
    [[+customconfigs.gridfunctions]]    
    
    
    $scope.columns = $scope.columns || {};
    $scope.items = $scope.items || {};
    $scope.columns.[[+tv.fieldname]] = angular.fromJson('[[+columns]]');    
    $scope.loadData[[+tv.fieldname]]();

</script>