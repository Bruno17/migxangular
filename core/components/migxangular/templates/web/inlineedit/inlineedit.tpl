<div id="[[+field]]_editable" data-wctx="[[+wctx]]" data-resource_id="[[+resource_id]]" data-configs="[[+configs]]" data-field="[[+field]]" data-object_id="[[+object_id]]" class="angular_editable" contenteditable="true">
  [[+value]]
</div>

<script type="text/javascript">

CKEDITOR.inline( '[[+field]]_editable', {
    on: {
        focus: function() {
            this.originalData = this.getData();    
        },
        blur: function() {

            
            if (this.checkDirty()){

                if (confirm('save modifications')){
                    //this.resetUndo();  
                    ma_mainController.updateInline($('#' + this.name).data(),this.getData());
                    this.resetDirty();                      
                }else{
                //this.setData(this.originalData);
                                  
                }
            }
 
        }
    },        
    toolbarGroups : [
    { name: 'document',    groups: [ 'mode', 'document', 'doctools' ] },
    { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
    { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
    //{ name: 'forms' },
    '/',
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
    { name: 'links' },
    { name: 'insert' },
    '/',
    { name: 'styles' },
    //{ name: 'colors' },
    { name: 'tools' },
    { name: 'others' },
    { name: 'about' }
]    
} );
</script>