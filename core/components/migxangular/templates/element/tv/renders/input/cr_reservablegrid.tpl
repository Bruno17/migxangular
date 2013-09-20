<div class="form-group">
<label for="tv[[+tv.id]]">
[[+tv.caption]]
</label>

<br />

<div class="btn-group">
<button ng-click="changeDateFilter[[+tv.fieldname]]('past')" class="btn {{past_btn_class}}" type="button">Vergangene</button>
<button ng-click="changeDateFilter[[+tv.fieldname]]('future')" class="btn {{future_btn_class}}" type="button">Kommende</button>
</div>

<div class="cr_cart_listings">
<div class="cr_cart_datebox" ng-repeat="date in result[[+tv.fieldname]].dateboxes" >
<h3>{{date.formateddate}}</h3>

<table class="cr_cart_listing" ng-repeat="reservation in date.reservations" >
<tr class="cr-cart-reservation" >
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
</td> 
</tr>
</table>

</div>
</div>

<hr />
</div> 



<script>
//this part gets inserted into the formCtrl[[+request.dialogCounter]] - controller

    $scope.changeDateFilter[[+tv.fieldname]] = function(date_filter){
        $scope.date_filter = date_filter;
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
    

    $scope.onClick[[+tv.fieldname]] = function(date){
        var items = $scope.result[[+tv.fieldname]].dateboxes;
        var index = this.$index;
        var dateitems = items[date];
        console.log(dateitems.reservations[index]);
        
        var reservation = dateitems.reservations[index];

        var cfg = Config;
        cfg.method = 'POST';

        var params = {}

        params.configs = 'bookings_angular';
        params.action = 'mgr/migxdb/process';
        params.processaction = 'updateres';
        //params.original_request_uri = request_uri;
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.data = {
            reservable: angular.toJson(reservation),
            data: angular.toJson($scope.bookingdata)
        };

        $http(ajaxConfig).success(function(response, status, header, config) {
            var success = response.success || false;
            var error = response.error || false;

            if (success) {
                //var data = success.data || false;
                $scope.refresh[[+tv.fieldname]]();

            } else if (error) {
                var message = error.msg || ''; 
                var data = error.data || false;               
                alert(message);
            }
            
            if (data){
                //var reservable = data.reservable || {};
                //var booking = data.booking || {};
                //$scope.setBooking(booking);
                //$scope.reservable = reservable;                 
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
            'limit':'10',
            'page':'1',
            'processaction':'getreservationlist',
            'booking_id': $scope.bookingdata.booking_id,
            'date_filter' : $scope.date_filter
        }
        
        var cfg = Config;
        cfg.method = 'GET';
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.url = Config.migxurl;
        $scope.[[+tv.fieldname]]_is_searching = true;
        $http(ajaxConfig).success(function(response, status, header, config) {
            //$scope.liveSearchCheckNewSearch[[+tv.fieldname]]();
            if (response.results){
                $scope.result[[+tv.fieldname]] = response.results;
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
    
    $scope.past_btn_class = 'btn-default';
    $scope.future_btn_class = 'btn-danger';      
    $scope.date_filter = 'future';
    $scope.refresh[[+tv.fieldname]]();
    

</script>