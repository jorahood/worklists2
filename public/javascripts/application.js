//assigning the YUI instance to wl2 to make it addressable for testing
var wl2 = YUI({
  base:"/javascripts/yui-3.0.0/",
  timeout: 1000,
  modules: {
    'yui-2.8.0r4-yde' : {
      fullpath: '/javascripts/yui-2.8.0r4/yahoo-dom-event/yahoo-dom-event.js'
    },
    'yui-2.8.0r4-yahoo' : {
      fullpath: '/javascripts/yui-2.8.0r4/yahoo/yahoo.js'
    },
    'yui-2.8.0r4-dom' : {
      fullpath: '/javascripts/yui-2.8.0r4/dom/dom.js',
      requires: ['yui-2.8.0r4-yahoo']
    },
    'yui-2.8.0r4-event' : {
      fullpath: '/javascripts/yui-2.8.0r4/event/event.js',
      requires: ['yui-2.8.0r4-yahoo']
    },
    'yui-2.8.0r4-datasource' : {
      fullpath: '/javascripts/yui-2.8.0r4/datasource/datasource.js',
      requires: ['yui-2.8.0r4-yahoo','yui-2.8.0r4-dom','yui-2.8.0r4-event']
    },
    'yui-2.8.0r4-element' : {
      fullpath: '/javascripts/yui-2.8.0r4/element/element.js',
      requires: ['yui-2.8.0r4-yahoo','yui-2.8.0r4-dom','yui-2.8.0r4-event']
    },
    'yui-2.8.0r4-datatable': {
      fullpath: '/javascripts/yui-2.8.0r4/datatable/datatable.js',
      requires: ['yui-2.8.0r4-datasource','yui-2.8.0r4-element','yui-2.8.0r4-datatable-css']
    },
    'yui-2.8.0r4-datatable-css': {
      fullpath: '/javascripts/yui-2.8.0r4/datatable/assets/skins/sam/datatable.css',
      type: 'css'
    },
    //FIXME: I do not use the separate jao-doctable anymore, get rid of this and the tests.
    'jao-doctable': {
      fullpath: '/javascripts/jao/doctable.js',
      requires: ['yui-2.8.0r4-datatable']
    }
  }

}).use('widget','dump','yui-2.8.0r4-datatable',function (Y,result) {
  Y.result = result;
  if (!result.success) {

    Y.log('Load failure: ' + result.msg, 'warn', 'Example');

  } else {
    //set module-wide constants, making them properties so they are accessible to tests
    //FIXME: functions within the docTable widget shouldn't be using these directly,
    // they should be passed in as arguments to the constructor.
    Y.TOGGLER_CLASS = 'toggler';
    Y.TOGGLEE_CLASS = 'togglee';
    Y.TOGGLER_ACTIVE_CLASS = 'toggler-active';
    Y.TOGGLEE_HIDDEN_CLASS = 'togglee-hidden';
    Y.TITLE_TOGGLER_CLASS = 'titles';
    Y.TOGGLE_COMPLETE = 'TOGGLE_COMPLETE';
    Y.FAST_FADE_ANIM = 'FAST_FADE_ANIM';
    Y.ANIMATE_HIDE = 'ANIMATE_HIDE';
    Y.ANIMATE_SHOW = 'ANIMATE_SHOW';
    Y.DOCTABLE_ID = 'doctable';
    Y.CONTENT_BOX_SELECTOR = 'div.table-plus'
    Y.SOURCE_TABLE = 'table';
    Y.SOURCE_KEY = 'a';
    Y.SOURCE_PARSER = '.doctable-parser'
    Y.LISTED_DOCS_TABLE = {
      Docid: {
        sortable:true
      },
      Titles: {
        sortable:true
      },
      Approveddate: {
        parser: "date",
        formatter:"date",
        sortable:true
      },
      Modifieddate: {
        parser: "date",
        formatter:"date",
        sortable:true
      },
      Birthdate: {
        parser: "date",
        formatter:"date",
        sortable:true
      },
      Domains: {
        sortable:true
      },
      Owner: {
        sortable:true
      },
      Author: {
        sortable:true
      },
      Refs: {
        sortable:true
      },
      Refbys: {
        sortable:true
      },
      "Boiler Name": {
        sortable:true
      },
      "Referenced Boilers": {
        sortable:true
      },
      Expirations: {
        sortable:true
      },
      Hotitems: {
        sortable:true
      },
      Importance: {
        sortable:true
      },
      Resources: {
        sortable:true
      },
      Status: {
        sortable:true
      },
      Visibility: {
        sortable:true
      },
      Volatility: {
        sortable:true
      },
      Kbas: {
        sortable:true
      },
      "Kba Bys": {
        sortable:true
      },
      Xtras: {
        sortable:true
      },
      Tags: {
        sortable:true
      },
      Notes: {
        sortable:true
      },
      Workstate: {
        sortable:true
      }
    };

    //----------------------------------------------------------
    //clone some dom nodes for running tests on
    //before the datatable changes them
    //----------------------------------------------------------
    contentBox = Y.one(Y.CONTENT_BOX_SELECTOR);
    Y.cloneContentBox =  contentBox ?
    contentBox.cloneNode(true) : null;

    //----------------------------------------------------------
    // DocTable - extends Widget-- This is the keystone.
    // Wrapping the 2.X DataSource and 2.X Datatable
    // in a YUI3 based Widget lets me make use of the
    // YUI3 design patterns by declaring properties that
    // Widget uses as callbacks to give the object common
    // handles for functionality.
    //----------------------------------------------------------

    function DocTable() {
      DocTable.superclass.constructor.apply(this, arguments);
    }

    DocTable.NAME = 'docTable';
    // declare our properties in ATTRS to have YUI generate getter and setter methods for them,
    // and to have it run the validator functions on passed in arguments
    DocTable.ATTRS = {
      // columns is the ColumnDefs object to pass to the 2.x datatable constructor
      // the 2.x dataSource object will be assigned to this property
      dataSource: {
        value: null
      },
      // the 2.x dataTable object will be assigned to this property
      dataTable: {
        value: null
      },
      // dtConfig is the 2.x dataTable config object
      dtConfig: {
        caption:'Listed Docs'
      },
      // inputHeaders is the text in the header nodes the html table we're enhancing. They are the basis of the Datasource
      // schemafields and the DataTable output columns.
      inputHeaders: {
        value: []
      },
      // the layout of the table to build from
      inputTableTemplate: {
        value: []
      },
      outputColumns: {
        value: null
      },
      // schemaFields is the source of the DataSource responseSchema's "fields" property,
      // it consists of the
      // FIXME: should have a validator function to make sure it is in the DOM
      schemaFields: {
        value: []
      },
      // sourceTable is the HTML table that dataSource will pull data from
      // FIXME: should have a validator function to make sure it is in the DOM
      sourceTable: {
        value:null
      }
    };

    // ----------------------------------------------------------------
    // define HTML_PARSER properties
    // http://developer.yahoo.com/yui/3/api/Widget.html#property_Widget.HTML_PARSER
    //-----------------------------------------------------------------
    DocTable.HTML_PARSER = {
      // the source table is the first table element inside the contentBox
      // where the dataTable will be rendered
      sourceTable : function(contentBox) {
        return contentBox.one('table')
      }
    };
    //
    //extend Widget, passing the methods to override on the prototype
    //
    Y.extend(DocTable, Y.Widget, {
      // initializer will be executed when we call new on DocTable
      initializer : function(cfg) {
        // instead of setting sourceTable, columns, and schemaFields in the HTML_PARSER separately,
        // I'm going to make use of the fact that the source table is also the source of the schema fields
        // as well as the columns to output in the datatable. So the only attr that I will parse from the page
        // is sourceTable, then I will set schemaFields and columns here in the initializer based on the node
        // I have for sourceTable.
        this.set('inputHeaders', this.initInputHeaders());
        this.set('schemaFields', this.initSchemaFields());
        this.set('dataSource', this.initDataSource());
        this.set('outputColumns', this.initOutputColumns());
      },
      renderUI : function() {
        // creating the 2.x datatable in the call to renderUI lets the 3 DocTable
        //  encapsulate rendering it in a YUI3 standard callback. _dataTable does
        //  not actually get addressed again except in tests but it seemed like a good idea
        //  to store a reference to the actual datatable in the docTable widget
        this.set('dataTable', this.renderDataTable());
      },
      initDataSource : function() {
        var plainOldDomSourceTable = Y.Node.getDOMNode(this.get('sourceTable'));
        var ds = new YAHOO.util.DataSource(plainOldDomSourceTable);
        ds.responseSchema = {
          fields: this.get('schemaFields')
        };
        return ds;
      },
      initInputHeaders : function() {
        var headers = this.get('sourceTable').all('tr.field-heading-row > th') || [];
        return headers;
      },
      initOutputColumns: function() {
        var cols = [];
        //the schemaFields will serve as keys to lookup the columns to output
        var lookup = this.get('inputTableTemplate');
        this.get('schemaFields').each(function(field){
          //the label ultimately comes from the contents of the <th>s in the
          // sourceTable. I already parsed these labels as the initSchemaFields
          // so I'm leveraging that here to assign properties to the outputColumn
          // keys
          var label = field['key'];
          cols.push({
            //outputColumn key is the same as the responseSchema field key
            key: label,
            //not sure how to format everything, dates are the only ones
            //with "formatter" entries, the rest will be null
            formatter: lookup[label]['formatter'],
            sortable: lookup[label]['sortable']
          })
        });
        return cols;
      },
      initSchemaFields : function() {
        var fields = [];
        //iterate over the header nodes to build the responseSchema fields
        var lookup = this.get('inputTableTemplate');
        this.get('inputHeaders').each(function(header){
          //use the text inside the anchor in each <th> as the label for each field
          var label = header.one('a').get('text');
          fields.push({
            key: label,
            //the only non-string parsers are the date columns
            parser: lookup[label]['parser'] || 'string'
          });
        });
        return fields;
      },
      renderDataTable : function() {
        var plainOldDomContentBox = Y.Node.getDOMNode(this.get('contentBox'));
        dt = new YAHOO.widget.DataTable(plainOldDomContentBox,
          this.get('outputColumns'),
          this.get('dataSource'),
          this.get('dtConfig'));
        return dt;
      }
    });
    // assign my widget to my YUI instance
    Y.DocTable = DocTable;

    //----------------------------------------------------------

    //instantiate a DocTable
    var docs = new Y.DocTable({
      // contentBox is a property inherited from Y.Widget that
      // tells Widget the div the widget will attach to when rendering the ui.
      // In this particular widget it is doing double duty to tell us where to find the HTML table
      // that will tell us what columns are present
      // to be parsed by the DataSource object, and consequently what columns will be output
      // by the DataTable.
      contentBox: Y.CONTENT_BOX_SELECTOR,
      inputTableTemplate: Y.LISTED_DOCS_TABLE
    });
    // render it- this calls renderUI which instantiates the 2.x datatable
    // which renders on instantiation. The datasource is created at initialization of the DocTable
    docs.render();
    // make it a property of the Y global so we can hold onto it
    // FIXME: it seems weird to have the class DocTable and the instance of DocTable, "docs"
    // both assigned to the Y object.
    Y.docs = docs;

  }
});
