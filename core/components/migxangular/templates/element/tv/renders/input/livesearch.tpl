<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]
</label>

<div class="livesearchitem-content active">
{{selected[[+tv.fieldname]].fullname}}
</div>

<div class="input-group">
<input class="form-control" 
  ng-change="onLiveSearchChange[[+tv.fieldname]]()" 
  ng-model="data.[[+tv.fieldname]]_term"
  ng-keydown="onKeyDown[[+tv.fieldname]]($event)" 
  ng-blur="onBlur[[+tv.fieldname]]()"
  ng-focus="onFocus[[+tv.fieldname]]()"
  id="tv[[+tv.id]]" name="tv[[+tv.id]]" type="text" 
/>
<span class="input-group-addon glyphicon glyphicon-search"></span>
</div>

<div class="livesearch-items animate-hide" ng-show="showitems[[+tv.fieldname]]">
<div class="livesearchitem" ng-mouseover="onMouseOver[[+tv.fieldname]]()" ng-click="onClick[[+tv.fieldname]]()" ng-repeat="result in result[[+tv.fieldname]]" >
<div class="livesearchitem-content {{result.activeclass}}" > {{result.fullname}}  </div>
</div>
<hr />
</div> 

</div>

<script>
//this part gets inserted into the formCtrl[[+request.dialogCounter]] - controller

    $scope.[[+tv.fieldname]]_is_searching = false;
    $scope.[[+tv.fieldname]]_query = '';
    
    $scope.onBlur[[+tv.fieldname]] = function(){
        $timeout(function() { $scope.showitems[[+tv.fieldname]]=false; }, 100);
        
    }
    
    $scope.onFocus[[+tv.fieldname]] = function(){
        $scope.showitems[[+tv.fieldname]]=true; 
    }    
    
    $scope.onMouseOver[[+tv.fieldname]] = function(){
        var items = $scope.result[[+tv.fieldname]];
        var index = this.$index;       
        var item = items[index];
        $scope.activate[[+tv.fieldname]](item); 
    } 
    
    $scope.onClick[[+tv.fieldname]] = function(){
        $scope.showitems[[+tv.fieldname]]=true;
        var items = $scope.result[[+tv.fieldname]];
        var index = this.$index;
        var item = items[index];
        $scope.select[[+tv.fieldname]](item);   
    } 
    
    $scope.onKeyDown[[+tv.fieldname]] = function(e){
        //activate prev/next
        if (e.keyCode === 40 || e.keyCode === 38){
            e.preventDefault(); 
            $scope.showitems[[+tv.fieldname]]=true;
            var items = $scope.result[[+tv.fieldname]];
            var index = items.indexOf($scope.active[[+tv.fieldname]]);
            if (e.keyCode === 40) {
                //scope.$apply(function() { controller.activateNextItem(); });
                var item = items[(index + 1) % items.length];
            }

            if (e.keyCode === 38) {
                var item = items[index === 0 ? items.length - 1 : index - 1]
               //scope.$apply(function() { controller.activatePreviousItem(); });
            }
            $scope.activate[[+tv.fieldname]](item);                      
        }
        
        if (e.keyCode === 9 || e.keyCode === 13) {
            $scope.select[[+tv.fieldname]]($scope.active[[+tv.fieldname]]);
        }        
        
    }
    
    $scope.activate[[+tv.fieldname]] = function(item) {
        var items = $scope.result[[+tv.fieldname]];
        for (var i = 0; i < items.length; i++) {
            items[i].activeclass = '';
        }
        
        item.activeclass = 'active';
        $scope.active[[+tv.fieldname]] = item;
        
    };    

    $scope.select[[+tv.fieldname]] = function(item){
        $scope.selected[[+tv.fieldname]] = item;
        $scope.data.[[+tv.fieldname]] = item['id']; 
        $scope.showitems[[+tv.fieldname]]=false;         
    }
    
    $scope.onLiveSearchChange[[+tv.fieldname]] = function(){
        
        if ($scope.[[+tv.fieldname]]_is_searching){
            return;
        }
        
        $scope.[[+tv.fieldname]]_query = $scope.data.[[+tv.fieldname]]_term;
        
        var params = {
            'action':'mgr/migxdb/process',
            'configs':'[[+request.configs]]',
            'limit':'10',
            'page':'1',
            'processaction':'[[+params.processaction:isnot=``:then=`[[+params.processaction]]`:else=`getlivesearch`]]',
            'query':$scope.data.[[+tv.fieldname]]_term
        }
        
        var cfg = Config;
        //cfg.method = 'POST';
        var ajaxConfig = UiDialog.prepareFormParams(cfg, params);
        ajaxConfig.url = Config.migxurl;
        $scope.[[+tv.fieldname]]_is_searching = true;
        $http(ajaxConfig).success(function(response, status, header, config) {
            $scope.liveSearchCheckNewSearch[[+tv.fieldname]]();
            $scope.result[[+tv.fieldname]] = response.results;
            $scope.showitems[[+tv.fieldname]]=true;
            
        }).error(function(data, status, header, config) {
            $scope.liveSearchCheckNewSearch[[+tv.fieldname]]();
            UiDialog.error(data, status, header, config);
            
        });
        
    }
    
    $scope.liveSearchCheckNewSearch[[+tv.fieldname]] = function(){
        $scope.[[+tv.fieldname]]_is_searching = false;
        if ($scope.[[+tv.fieldname]]_query != $scope.data.[[+tv.fieldname]]_term){
            $scope.onLiveSearchChange[[+tv.fieldname]]();    
        }            
    }    

</script>