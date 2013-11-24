<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" class="modal fade" id="ekathuwaModalTemp1" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
        
<div ng-controller="formCtrl[[+request.modal_id]]" class="ma-form">
            <div class="modal-header">
                <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                <h4 id="myModalLabel" class="modal-title">MIGXangular</h4>
            </div>
<form>


            <div class="modal-body">
                <h4>MIGXangular</h4>


<div data-ma-tabs id="tabs">
    <ul>
    [[+innerrows.tab]]
    </ul>
    [[+innerrows.tab_content]]
</div>            
            
</form>

            <div class="modal-footer">
                [[+innerrows.button]]
            </div>

</div>
        
        



        </div>
    </div>
</div>

<script type="text/javascript">

function formCtrl[[+request.modal_id]]($scope, $ekathuwa, $timeout, $http, $sanitize, $rootScope, $filter, Config, UiDialog){

    [[+innerrows.controller_scripts]]
    
}

</script>       

