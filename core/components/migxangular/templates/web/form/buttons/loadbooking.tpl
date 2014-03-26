<button type="button" ng-click = "onBooDoneButtonClick()" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
<span class="ui-button-text">Buchung laden</span>
</button>

<script>

    $scope.onBooDoneButtonClick = function() {
        var dialog = $scope.dialogOptions.jquiDialog;
        var cfg = Config;
        cfg.method = 'POST';
        
        var params = {
            'closeonsuccess':true,
            'configs':'cr_bookings_angular',
            'object_id':'[[+request.object_id]]',
            'resource_id':'[[+request.resource_id]]',
            'wctx':'[[+request.wctx]]',
            'field':'[[+request.field]]',
        }
        
        params.action = 'mgr/migxdb/process';
        params.processaction = 'loadbooking';
        
        var ajaxConfig = UiDialog.preparePostParams(cfg, params);
        ajaxConfig.data = {
            data : angular.toJson($scope.data),
            bookingdata : angular.toJson($scope.bookingdata)
        };
        $http(ajaxConfig).success(function(response, status, header, config) {
            if (params.closeonsuccess){
                var dialog = $scope.dialogOptions.jquiDialog;
                dialog.dialog('close'); 
                
                if (response.success){
                    var booking = response.object || false;
                    if (booking){
                       $scope.setBooking(booking);     
                    }
                    
                }
                
                //$("#reservation_calendar").replaceWith(response.object.html);
                //assignRememberAdd();                
                               
            }
        }).error(function(data, status, header, config) {
            UiDialog.error(data, status, header, config);
        });
        
        //dialog.dialog('close');
    }
    
</script>        