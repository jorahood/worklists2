YUI.add('jao-doctable', function(Y) {
    function DocTable() {
        DocTable.superclass.constructor.apply(this, arguments);
    };

    DocTable.NAME = 'docTable';
    DocTable.ATTRS = {
        columns: {
            validator: function(val) {
                return Y.Lang.isArray(val);
            }
        },
        sourceFields: {
            value:null
        },
        sourceTable: {},
        table: {},
        element :{}
    };

    DocTable.HTML_PARSER = {
        sourceFields : function() {}
    };
    Y.extend(DocTable, Y.Widget, {});
    Y.DocTable = DocTable;

},'0.0.1',{
    requires: ['widget','yui2.6-yahoo','yui2.6-dom','yui2.6-event','yui2.6-datasource','yui2.6-element','yui2.6-datatable','yui2.6-datatable-css']
});