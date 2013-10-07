
<div ng-controller="formCtrl[[+request.dialogCounter]]" class="ma-form">

<form>

<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">

<div class="ui-dialog-buttonset">
[[+innerrows.button]]
</div>

</div>
<div >

<div data-ma-tabs id="tabs">
    <ul>
    [[+innerrows.tab]]
    </ul>
    [[+innerrows.tab_content]]
</div>

    
</div>

</form>
</div>


<script type="text/javascript">

function formCtrl[[+request.dialogCounter]]($scope, $timeout, $http, $sanitize, $rootScope, $filter, Config, UiDialog){

    [[+innerrows.controller_scripts]]
    
}

</script>






