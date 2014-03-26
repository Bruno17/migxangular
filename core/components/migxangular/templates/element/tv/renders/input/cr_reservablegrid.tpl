<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]
</label>

<br />

<div class="btn-group">
<button ng-click="changeDateFilter[[+tv.fieldname]]('past')" class="btn {{past_btn_class}}" type="button">Vergangene</button>
<button ng-click="changeDateFilter[[+tv.fieldname]]('future')" class="btn {{future_btn_class}}" type="button">Kommende</button>
</div>
<div class="btn-group">
<button ng-click="changeBookingFilter[[+tv.fieldname]](0)" class="btn {{allbookings_btn_class}}" type="button">Alle Buchungen</button>
<button ng-click="changeBookingFilter[[+tv.fieldname]]({{bookingdata.booking_id}})" class="btn {{activebooking_btn_class}}" type="button">Aktive Buchung</button>
</div>

<div class="form-group">
<label for="selectedCategory">
Aktive Regenplatzkategorie
</label>

<select id="selectedCategory" class="form-control" ng-model="raincategory[[+tv.fieldname]]" ng-options="i.id as i.name for i in courtcategories"></select>

</div>

<div class="form-group">
<label for="selectedCoach">
Aktiver Coach
</label>

<select id="selectedCoach" class="form-control" ng-model="coach[[+tv.fieldname]]" ng-options="i.id as i.fullname for i in coaches"></select>

</div>

<div class="form-group">
<label for="filteredCoach">
Coach Filter
</label>

<select id="filteredCoach" ng-change="changeCoach[[+tv.fieldname]]()" class="form-control" ng-model="coachfilter[[+tv.fieldname]]" ng-options="i.id as i.fullname for i in coaches"></select>

</div>

<div class="cr_cart_listings">

<div class="btn-group">
  <button ng-click="changePage[[+tv.fieldname]]()" ng-repeat="page in pages[[+tv.fieldname]]" class="btn {{page.btn_class}}" ng-bind-html="page.label"></button>
</div>


<div class="cr_cart_datebox" ng-repeat="date in result[[+tv.fieldname]].dateboxes" >
<h3>{{date.formateddate}}</h3>

<table class="cr_cart_listing"  >
<thead>
<tr>
<th></th>
<th></th>
<th></th>
<th></th>
<th>Regenplatz</th>
</tr>
</thead>
<tbody>
<tr class="cr-cart-reservation" ng-repeat="reservation in date.reservations">
<td class="cart-td cartlist-court_name">{{reservation.Court_name}}</td> 
<td class="cart-td cartlist-hour">{{reservation.hour_text}}</td> 
<td class="cart-td cartlist-price">{{reservation.price}},- Fr.</td> 
<td>
<div id="res_[[+court_id]]_[[+hour]]_[[+date:strtotime:date=`%Y%m%d`]]"  class="reservable_listing reservable_status_{{result.status}} date-head platznummer frei {{reservation.Booking_booking_group}}">
<div class="btn_rememberadd btn_status_{{reservation.input_value}}" >
<div class="btn-group pull-right">
          <button ng-click="onClick[[+tv.fieldname]]('{{date._idx}}')" title="{{reservation.change_status_text}}" class="btn btn-default" type="button"><span class="glyphicon glyphicon-remove"></span></button>
          <button ng-click="editReservation()" class="btn btn-default hide_{{reservation.input_value}}" type="button"><span class=" glyphicon glyphicon-pencil"></span></button>          
</div>
{{reservation.status_text}}
</div>
</div>
<div class="reservable_details ">
<div class="btn_rememberadd">
<strong >Coaches </strong>
<div class="btn-group pull-right">
          <button ng-click="addCoach[[+tv.fieldname]]('{{reservation.id}}')" title="{{reservation.add_coach_text}}" class="btn btn-default" type="button"><span class="glyphicon glyphicon-plus"></span></button>
</div>
</div>
<ul >
<li ng_repeat="coach in reservation.coaches" class="btn_rememberadd">{{coach.fullname}}
<div class="btn-group pull-right">
          <button ng-click="removeCoach[[+tv.fieldname]]('{{reservation.id}}','{{coach.id}}')" title="{{reservation.remove_coach_text}}" class="btn btn-danger" type="button"><span class="glyphicon glyphicon-remove"></span></button>
</div>
</li>
</ul>
</div>
</td> 
<td>
<div class="reservable_listing reservable_status_{{result.status}} date-head platznummer frei {{reservation.Booking_booking_group}}">
<div class="btn_rememberadd btn_status_{{reservation.RainSister_input_value}}" >
<div class="btn-group pull-right">
    <button ng-click="switchHasRainStatus[[+tv.fieldname]]('{{reservation.RainSister_input_value}}','{{reservation.id}}')" title="{{reservation.change_status_text}}" class="btn btn-default" type="button"><span class="glyphicon glyphicon-{{reservation.RainSister_glyphicon}}"></span></button>
    <button ng-click="editReservation()" class="btn btn-default hide_{{reservation.RainSister_input_value}}" type="button"><span class=" glyphicon glyphicon-pencil"></span></button>          
</div>
{{reservation.RainSister_status_text}}
</div>
</div>
<div class="reservable_details ">
{{reservation.RainSisterCourt_name}}
</div>
</td> 
</tr>
</tbody>
</table>

</div>
</div>

<hr />
</div> 



<script>
//this part gets inserted into the formCtrl[[+request.dialogCounter]] - controller

    $scope.changeCoach[[+tv.fieldname]] = function(){
        $scope.resetPage[[+tv.fieldname]]();
        $scope.refresh[[+tv.fieldname]](); 
    }
    
    $scope.changeDateFilter[[+tv.fieldname]] = function(date_filter){
        $scope.date_filter = date_filter;
        $scope.resetPage[[+tv.fieldname]]();
        $scope.refresh[[+tv.fieldname]](); 
        if (date_filter == 'past'){
            $scope.past_btn_class = 'btn-danger';
            $scope.future_btn_class = 'btn-default';  
        }
        else{
            $scope.past_btn_class = 'btn-default';
            $scope.future_btn_class = 'btn-danger';              
        }
          
    }
    
    $scope.changeBookingFilter[[+tv.fieldname]] = function(booking_filter){
        $scope.booking_filter = booking_filter;
        $scope.resetPage[[+tv.fieldname]]();
        $scope.refresh[[+tv.fieldname]](); 
        if (booking_filter == 0){
            $scope.allbookings_btn_class = 'btn-danger';
            $scope.activebooking_btn_class = 'btn-default';  
        }
        else{
            $scope.allbookings_btn_class = 'btn-default';
            $scope.activebooking_btn_class = 'btn-danger';              
        }
          
    }    

    $scope.addCoach[[+tv.fieldname]] = function(reservation){
        var processaction = 'addcoach';
        var data = {
            reservation_id: reservation,
            coach_id: $scope.coach[[+tv.fieldname]]
            //data: angular.toJson($scope.bookingdata)
        };
                
        $scope.process[[+tv.fieldname]](data,processaction);           
    }    

    $scope.removeCoach[[+tv.fieldname]] = function(reservation,coach){
        var processaction = 'removecoach';
        var data = {
            reservation_id: reservation,
            coach_id: coach
            //data: angular.toJson($scope.bookingdata)
        };
                
        $scope.process[[+tv.fieldname]](data,processaction);     
    } 
    
    $scope.switchHasRainStatus[[+tv.fieldname]] = function(status,reservation){
         
        var processaction = 'switchhasrainstatus';
        var data = {
            reservation_id: reservation,
            status: status,
            courtcategory: $scope.raincategory[[+tv.fieldname]]
        };
                
        $scope.process[[+tv.fieldname]](data,processaction);            
    }
    
    $scope.onClick[[+tv.fieldname]] = function(date){
        var items = $scope.result[[+tv.fieldname]].dateboxes;
        var index = this.$index;
        var dateitems = items[date];
        
        var reservation = dateitems.reservations[index];
        var processaction = 'updateres';
        var data = {
            reservable: angular.toJson(reservation),
            data: angular.toJson($scope.bookingdata)
        };
                
        $scope.process[[+tv.fieldname]](data,processaction);
        
    }
    
    $scope.process[[+tv.fieldname]] = function(data,processaction){
        var cfg = Config;
        cfg.method = 'POST';

        var params = {}

        params.configs = 'cr_bookings_angular';
        params.action = 'mgr/migxdb/process';
        params.processaction = processaction;
        //params.original_request_uri = request_uri;
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.data = data;

        $http(ajaxConfig).success(function(response, status, header, config) {
            var success = response.success || false;
            var error = response.error || false;

            if (success) {
                $scope.refresh[[+tv.fieldname]]();

            } else if (error) {
                var message = error.msg || ''; 
                var data = error.data || false;               
                alert(message);
            }else if (response.message){
                alert (response.message);
            }
            

        }).error(function(data, status, header, config) {
            UiDialog.error(data, status, header, config);
        });        
    }    
    

    $scope.refresh[[+tv.fieldname]] = function(){
        
        /*
        if ($scope.[[+tv.fieldname]]_is_searching){
            return;
        }
        */
        
        var params = {
            'action':'mgr/migxdb/process',
            'configs':'[[+request.configs]]',
            'limit':$scope.pageSize[[+tv.fieldname]],
            'start':$scope.PageStart[[+tv.fieldname]],
            'processaction':'getreservationlist',
            'booking_id': $scope.booking_filter,
            'date_filter' : $scope.date_filter,
            'coach_filter' : $scope.coachfilter[[+tv.fieldname]]
        }
        
        var cfg = Config;
        cfg.method = 'GET';
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.url = Config.migxurl;
        $scope.[[+tv.fieldname]]_is_searching = true;
        $http(ajaxConfig).success(function(response, status, header, config) {
            //$scope.liveSearchCheckNewSearch[[+tv.fieldname]]();
            if (response.results){
                var total = response.total || 0;
                $scope.result[[+tv.fieldname]] = response.results;
                $scope.generatePages[[+tv.fieldname]](total);
                //$scope.showitems[[+tv.fieldname]]=true;                
            }
            else{
                if (response.message){
                    alert(response.message);
                }
                
            }

            
        }).error(function(data, status, header, config) {
            //$scope.liveSearchCheckNewSearch[[+tv.fieldname]]();
            UiDialog.error(data, status, header, config);
            
        });
        
    }
    
    $scope.changePage[[+tv.fieldname]] = function(){
        var page = $scope.pages[[+tv.fieldname]][this.$index].number;
        var start = $scope.pages[[+tv.fieldname]][this.$index].start;
        if (page){
          $scope.currentPage[[+tv.fieldname]] = page;
          $scope.PageStart[[+tv.fieldname]] = start;
          $scope.refresh[[+tv.fieldname]]();                
        }
    }

    $scope.resetPage[[+tv.fieldname]] = function(){
          $scope.currentPage[[+tv.fieldname]] = 1;
          $scope.PageStart[[+tv.fieldname]] = 0;        
    }
    
    $scope.generatePages[[+tv.fieldname]] = function(totalItems){
        var currentPage = $scope.currentPage[[+tv.fieldname]] || 1;
        var pageSize = $scope.pageSize[[+tv.fieldname]] || 10;
        var pages = UiDialog.generatePages(currentPage, totalItems, pageSize,{'showFirst':false,'showLast':false});
        $scope.pages[[+tv.fieldname]] = pages;
    }
    
    
    $scope.pageSize[[+tv.fieldname]] = 20;
    $scope.courtcategories = angular.fromJson('[[+courtcategories]]');
    $scope.coaches = angular.fromJson('[[+coaches]]');
    $scope.past_btn_class = 'btn-default';
    $scope.future_btn_class = 'btn-danger';      
    $scope.date_filter = 'future';
    $scope.allbookings_btn_class = 'btn-default';
    $scope.activebooking_btn_class = 'btn-danger';
    $scope.booking_filter = $scope.bookingdata.booking_id;
    $scope.resetPage[[+tv.fieldname]]();
    $scope.refresh[[+tv.fieldname]]();
    

</script>