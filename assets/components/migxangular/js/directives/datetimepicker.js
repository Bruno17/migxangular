migxAngular.directive('datetimepicker', function() {
    return {
        restrict: 'A',
        require : 'ngModel',
        link : function (scope, element, attrs, ngModelCtrl) {
            $(function(){
                var dp = element.datetimepicker({
                format: "yyyy-mm-dd hh:ii:ss",
                showMeridian: false,
                autoclose: true,
                todayBtn: true,
                todayHighlight: true
                //endDate: new Date()
                });
                
                dp.on('changeDate', function(ev){
                    ngModelCtrl.$setViewValue(ev.target.value);
                    scope.$apply();                    
                });
                
            });
        }
    }    
    
});

