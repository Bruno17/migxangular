var migxAngular = angular.module('migxAngular', ['ngSanitize']);
var globals = {
    timeoutInMs: 5000,
    dialogCounter: 0
};

migxAngular.filter('nl2br', function() {
    return function(input) {
        return input.replace(/\n/g, '<br/>');
    }
});
migxAngular.factory('Config', function() {
    return {
        url: 'assets/components/migxangular/connector.php',
        migxurl: 'assets/components/migx/connector.php',
        baseParams: {
            'HTTP_MODAUTH': '[[+auth]]',
            'original_request_uri' : '[[+request_uri]]'
        }
    }
});
/*
initial code taken from here:
http://stackoverflow.com/questions/18078233/angularjs-nested-modal-dialogs
*/
migxAngular.factory('UiDialog', ['$http', '$compile', function($http, $compile) {
    
    //$http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
    
    var service = {};
    
    service.loadChildDialog = function(parentscope, Config, params, rootScope, dialogOptions) {
        var scope = rootScope.$new();
        scope.parentdatas = angular.copy(parentscope.parentdatas || []);
        scope.parentdatas.push(parentscope.data);
        service.loadDialog(scope, Config, params, dialogOptions);
    };
    
    service.loadDialog = function(scope, Config, params, dialogOptions) {
        //loading the formtabs + datas
        
        var ajaxConfig = service.prepareFormParams(Config, params);
        $http(ajaxConfig).success(function(response, status, header, config) {
            scope.data = response.data;
            service.showDialog(scope, response, params, dialogOptions);
        }).error(function(data, status, header, config) {
            service.error(data, status, header, config);
        });
    };
    
    service.prepareFormParams = function(Config, params) {
        var baseParams = angular.copy(Config.baseParams);
        var params = angular.extend(baseParams, params);
        params.dialogCounter = globals.dialogCounter;
        var ajaxConfig = {
            url: Config.url,
            params: params,
            method: Config.method || 'GET',
            responseType: 'json',
            timeout: globals.timeoutInMs,
            cache: false
        }
        return ajaxConfig;
    };
    
    service.preparePostParams = function(Config, params) {
        var baseParams = angular.copy(Config.baseParams);
        var params = angular.extend(baseParams, params);
        params.dialogCounter = globals.dialogCounter;
        var ajaxConfig = {
            url: Config.migxurl,
            params: params,
            method: Config.method || 'POST',
            responseType: 'json',
            timeout: globals.timeoutInMs,
            cache: false,
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            transformRequest: function(obj) {
                var str = [];
                for(var p in obj){
                    str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                }    
                return str.join("&");
            }            
        }
        return ajaxConfig;
    };    
    
    service.showDialog = function(scope, response, params, dialogOptions, callback) {
        var newDialogId = sprintf("npInnerDlg%d", globals.dialogCounter);
        var modalEl = angular.element('<div id="' + newDialogId + '">');
        globals.dialogCounter += 1;
        scope.dialogOptions = dialogOptions;
        scope.dialogOptions.callback = callback;
        modalEl.html(response.html);
        $('body').append(modalEl);
        $compile(modalEl)(scope);
        var component = $('#' + newDialogId);
        scope.dialogOptions.jquiDialog = component;
        component.dialog({
            autoOpen: false,
            modal: true,
            title: params.win_title,
            width: 900,
            maxHeight: 800,
            position: {
                my: 'top+100',
                at: 'top',
                of: '#ma-maintoolbar'
            }
            
/*         ,buttons: [{
                text: 'Ok',
                'ng-click': 'onButtonClick({"configs":"test","object_id":"5","resource_id":"5","wctx":"web","field":"feld","action":"web/migxdb/fields","processaction":""})'  
                  
            }]
            */
        });
        component.on("dialogclose", function(event, ui) {
            component.remove();
        });
        component.dialog("open");
    };
    service.error = function(data, status, header, config) {
        document.body.style.cursor = 'default';
        if (status == 406) {
            console.log("Received 406 for:" + header + " # " + config);
            alert("Received 406 from web service...");
        } else {
            console.log("Status:" + status);
            console.dir(config);
            alert("Timed-out waiting for data from server...");
        }
    };
          service.generatePages = function(currentPage, totalItems, pageSize, config) {
            var maxBlocks, maxPage, maxPivotPages, minPage, numPages, pages;
            var config = config || {};
            var maxBlocks = config.maxBlocks || 11;
            var showFirst = config.showFirst;
            var showLast = config.showLast;
                        
            pages = [];
            numPages = Math.ceil(totalItems / pageSize);
            if (numPages > 1) {
              if (showFirst){
                pages.push({
                  type: "first",
                  number: 1,
                  start: 0,
                  label: "",
                  active: currentPage > 1
                });                
              }
              number = Math.max(1, currentPage - 1);
              pages.push({
                type: "prev",
                number: number,
                label: "&laquo;",
                active: currentPage > 1,
                start: (number-1) * pageSize,
                btn_class: 'btn-default'
              });
              maxPivotPages = Math.round((maxBlocks - 5) / 2);
              minPage = Math.max(1, currentPage - maxPivotPages);
              maxPage = Math.min(numPages, currentPage + maxPivotPages * 2 - (currentPage - minPage));
              minPage = Math.max(1, minPage - (maxPivotPages * 2 - (maxPage - minPage)));
              i = minPage;
              while (i <= maxPage) {
                if (currentPage == i){
                    btn_class = 'btn-danger';
                }else{
                    btn_class = 'btn-default';
                }
                
                if ((i === minPage && i !== 1) || (i === maxPage && i !== numPages)) {
                  pages.push({
                    type: "more",
                    label: "...",
                    number: 0,
                    btn_class: 'btn-default'
                  });
                } else {
                  pages.push({
                    type: "page",
                    number: i,
                    start: (i-1) * pageSize,
                    label: "<span>" + i +"</span>",
                    active: currentPage !== i,
                    btn_class: btn_class
                  });
                }
                i++;
              }
              number = Math.min(numPages, currentPage + 1)
              pages.push({
                type: "next",
                number: number,
                start: (number-1) * pageSize,
                label: "&raquo;",
                active: currentPage < numPages,
                btn_class: 'btn-default'
              });
              if (showLast){
                pages.push({
                  type: "last",
                  number: numPages,
                  start: (numPages-1) * pageSize,
                  label: "",
                  active: currentPage !== numPages
                });
              }              
            }
            return pages;
          };    
    
    return service;
}]);

function toolbarCtrl($scope, $http, Config, UiDialog) {
    $scope.config = Config;
    $scope.onButtonClick = function(params) {
        var dialogOptions = {
            callback: function() {
                if (dialogOptions.result !== undefined) {
                    cust.mncId = dialogOptions.result.whateverYouWant;
                }
            },
            result: {}
        };
        
        UiDialog.loadDialog($scope, Config, params, dialogOptions);
        
    }
    
    [[+customhandlers]]    
}

migxAngular.directive('maTabs', function() {
    return {
        restrict: 'A',
        link: function(scope, elm, attrs) {
            var jqueryElm = $(elm[0]);
            $(jqueryElm).tabs()
        }
    };
});