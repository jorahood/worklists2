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

        // FIXME: the columns that will be output needs to be tied to the columns input
        //  into the dataSource. So need to pull from the DOM to get both the schemaFields columns
        //  and the outputDataTable columns. Maybe use the schemaFields to build the outputTableColumns
        // FIXME: then all I need to hardcode is the correlation of possible header names and the parser that
        // the data for that column will have. And sortability. And formatting. But then I would just have one
        // object to handle all the lookups for input and output, and the number of columns would depend on the
        // number of columns in the underlying HTML table. 
        var outputTableColumns = [
        {
            key:'Doc',
            label:"Docid",
            sortable:true
        },{
            key:'Doc Titles',
            label:"Title",
            sortable:true
        },{
            key:'Doc Birthdate',
            label:"Birth",
            formatter:"date",
            sortable:true
        },{
            key:'Doc Modifieddate',
            label:"Modified",
            formatter:"date",
            sortable:true
        },{
            key:'Doc Approveddate',
            label:'Approved',
            formatter:"date",
            sortable:true
        },{
            key:'Doc Owner',
            label:'Owner',
            sortable:true
        },{
            //    key:'Doc Author',
            //    label:'Author',
            //    sortable:true
            //  },{
            //    key:'Doc Importance',
            //    label:'Importance',
            //    sortable:true
            //  },{
            key:'Doc Visibility',
            label:'Visibility',
            sortable:true
        },{
            key:'Doc Volatility',
            label:'Volatility',
            sortable:true
        },{
            key:'Doc Status',
            label:'Status',
            sortable:true
        },{
            key:'Notes',
            sortable:true
        },{
            key:'Controls',
            label:'Controls'
        }
        ];
        Y.COLUMN_LOOKUP = {
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
            outputColumns: {
              value: null
            },
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
            // headers is the headers of the html table we're enhancing. They are the basis of the Datasource
            // schemafields and the DataTable output columns.
            //FIXME: rename headers to inputHeaders
            headers: {
              value: []
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
                this.set('headers', this.initHeaders());
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
            initHeaders : function() {
              var headers = this.get('sourceTable').all('tr.field-heading-row > th') || [];
              return headers;
            },
            initOutputColumns: function() {
              var cols = [];
              //the schemaFields will serve as keys to lookup the columns to output
              this.get('schemaFields').each(function(field){
                //the label ultimately comes from the contents of the <th>s in the
                // sourceTable. I already parsed the text out with initSchemaFields
                // so I'm leveraging that here to assign the text to the outputColumn
                // keys
                var label = field['key'];
                cols.push({
                  //outputColumn key is the same as the responseSchema field key
                  key: label,
                  //not sure how to format everything, dates are the only ones
                  //with "formatter" entries
                  formatter: Y.COLUMN_LOOKUP[label]['formatter'] || 'text'
                })
              });
              return cols;
            },
            initSchemaFields : function() {
              var fields = [];
              //iterate over the header nodes to build the responseSchema fields
                this.get('headers').each(function(header){
                  //use the text inside the anchor in each <th> as the label for each field
                  var label = header.one('a').get('text');
                    fields.push({
                        key: label,
                        //the only non-string parsers are the date columns
                        parser: Y.COLUMN_LOOKUP[label]['parser'] || 'string'
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
            contentBox: Y.CONTENT_BOX_SELECTOR
        });
        // render it- this calls renderUI which instantiates the 2.x datatable
        // which renders on instantiation. The datasource is created at initialization of the DocTable
                docs.render();
       // make it a property of the Y global so we can hold onto it
       // FIXME: it seems weird to have the class DocTable and the instance of DocTable, "docs"
       // both assigned to the Y object.
        Y.docs = docs;

















        //----------------------------------------------------------
        // SET UP FOR UNIT TESTING BELOW
        //
        //
        //testing instance of YUI
        //----------------------------------------------------------
        YUI({
            base:"/javascripts/yui-3.0.0/",
            timeout: 1000//,
        //insertBefore: 'styleoverrides'
        }).use("console","test", "dump", function (Y) {

            Y.namespace("wl2Tests");
            Y.wl2Tests.DocTableImplementation = new Y.Test.Case({
                name: "DocTable Implementation Tests (using internal and private methods and state)",
                setUp : function () {
                },
                tearDown : function () {
                },
                _should: {
                    fail: {},
                    error: {},
                    ignore : {}
                },
                test_makeDataSourceMethod : function() {
                    Y.Assert.isFunction(wl2.docs._makeDataSource,'a function that constructs a datasource from HTML table data');
                    var myDS = wl2.docs._makeDataSource(wl2.docs.get('sourceTable'),[{
                        key:'Doc'
                    }]);
                    Y.Assert.isNotUndefined(myDS.parseData,
                        'duck-typing that _makeDataSource(oSourceTableNode) produces a 2.6 DataSource');
                    Y.Assert.areSame('Doc', myDS.responseSchema.fields[0].key, 'the fields have to be loaded into the responseSchema');
                    //cribbed the next tests from yui-2.8.0r4/tests/datasource.html
                    //FIXME: Y.Node.getDOMNode(wl2.docs.get('contentBox')) fails because the contentBox isn't really a Node but can act like
                    //one WITHIN THE SAME INSTANCE by using its "_yuid" guid to reference the node. It doesn't work with getDOMNode running
                    //on a different instance of YUI though, as above. So I need to decouple these tests from the wl2 YUI instance and set up
                    //a completely separate test instance of DocTable
                    Y.Assert.areSame(wl2.docs.get('sourceTable').get('nodeName'), wl2.docs._dataSource.liveData.nodeName,
                        'the nodeName should be "TABLE"');
                    Y.Assert.areSame(YAHOO.util.DataSource.TYPE_LOCAL, wl2.docs._dataSource.dataType, 'the dataType should be "type_local"');
                    Y.Assert.areSame(YAHOO.util.DataSource.TYPE_HTMLTABLE, wl2.docs._dataSource.responseType,
                        'dataSource should set the responseType automagically to "type_htmltable" after examining the sourceTable');
                //FIXME: mock YAHOO.util.DataSource to make these tests more independent
                },
                test_makeDataTableMethod : function () {
                    Y.Assert.isFunction(wl2.docs._makeDataTable,'a function that constructs a DataTable instance');
                    var containerDiv = wl2.docs.get('contentBox');
                    var cols = wl2.docs.get('columns');
                    var myDS = wl2.docs._makeDataSource(wl2.docs.get('sourceTable'),[{
                        key:'Doc'
                    }]);
                    var config = {
                        caption:'Docs'
                    };
                    var oMockDT = Y.Mock();
                    var fnMockDT = function () {
                        oMockDT.new_got_called(arguments[0],arguments[1],arguments[2],arguments[3]);
                    };
                    Y.Mock.expect(oMockDT, {
                        method: 'new_got_called',
                        args: [wl2.Node.getDOMNode(containerDiv), cols, myDS, config]
                    });
                    wl2.docs._makeDataTable(containerDiv, cols, myDS,fnMockDT,config);
                },
                testDocTable_dataSourceProp : function () {
                    Y.Assert.isNotUndefined(wl2.docs._dataSource, 'the YUI 2.6 datasource instance needed by _dataTable');
                    Y.Assert.isNotUndefined(wl2.docs._dataSource.parseData, 'duck-typing that the DS gets assigned to _dataSource');
                },
                testDocTable_dataTableProp : function () {
                    Y.Assert.isNotUndefined(wl2.docs._dataTable, 'the YUI 2.6 datatable instance');
                    Y.Assert.isNotUndefined(wl2.docs._dataTable.addRow, 'duck-typing that the DT gets assigned to _dataTable');
                }
            });
            Y.wl2Tests.DocTableInterface = new Y.Test.Case({
                name: "DocTable Interface Tests (black box testing DocTable, not referencing internal state)",
                setUp : function () {
                    this.testContentBox = wl2.cloneContentBox ? wl2.cloneContentBox.cloneNode(true) : null;
                    this.testDocTable = new wl2.DocTable({
                        contentBox: this.testContentBox,
                        columns : outputTableColumns
                    });
                },
                tearDown : function () {
                    delete this.testDocTable;
                },
                _should: {
                    fail: {},
                    error: {},
                    ignore : {}
                },
                //
                //testing DocTable class has prereqs for extending Base
                //
                testDocTableIsFn : function () {
                    Y.Assert.isFunction(wl2.DocTable, 'this should be a function so I can create new instances of it');
                },
                testDocTableHasWidgetPrereqs : function () {
                    Y.Assert.isString(wl2.DocTable.NAME, 'required by Widget, NAME is used to identify instances of this class');
                    Y.Assert.isObject(wl2.DocTable.ATTRS, 'required by Widget, ATTRS is where you define all attibutes for the class');
                    Y.Assert.isObject(wl2.DocTable.HTML_PARSER, 'required by Widget, HTML_PARSER lets you pull config data from the DOM')
                },
                testDocTableClassNAMEEqualsString : function () {
                    Y.Assert.areSame(wl2.DocTable.NAME, 'docTable', '"docTable" will be prepended to the labels of any events emitted by DocTable instances');
                },
                testDocTableExtendsWidget : function () {
                    Y.Assert.isNotUndefined(this.testDocTable.get, 'duck-typing DocTable extends Widget: instances should have a "get" method');
                    Y.Assert.isNotUndefined(this.testDocTable.set, 'duck-typing DocTable extends Widget: instances should have a "set" method');
                    Y.Assert.isNotUndefined(this.testDocTable.getAtts, 'duck-typing DocTable extends Widget: instances should have a "getAtts" method');
                    Y.Assert.isNotUndefined(this.testDocTable.render, 'duck-typing DocTable extends Widget: instances should have a "render" method');
                },
                //
                //testing DocTable attributes
                //
                testDocTableHasColumnsAtt : function () {
                    this.testDocTable.set('columns',[]);
                    Y.Assert.isNotUndefined(this.testDocTable.get('columns'), 'it should have a columns attribute')
                },
                testColumnsAttCanBeSetOnlyToAnArray : function () {
                    this.testDocTable.set('columns',[]);
                    Y.Assert.isInstanceOf(Array, this.testDocTable.get('columns'), 'should be an array of column definitions');
                    var string = "OOPS! NOT AN ARRAY!"
                    this.testDocTable.set('columns',string);
                    Y.Assert.areNotEqual(string, this.testDocTable.get('columns'), 'should not be able to set columns to "'+string+'"');
                },
                testDocTableHasschemaFieldsAtt : function () {
                    this.testDocTable.set('schemaFields',[]);
                    Y.Assert.isNotUndefined(this.testDocTable.get('schemaFields'), '"schemaFields": an array of field names provided by the YAHOO.DataSource for the YAHOO.DataTable')
                },
                testDocTableHasSourceTableAtt : function() {
                    this.testDocTable.set('sourceTable','');
                    Y.Assert.isNotUndefined(this.testDocTable.get('sourceTable'), '"sourceTable": a <table> element from the DOM for DataSource to pull data from');
                },
                //
                //testing that the wl2.docs instance's attributes are being initialized to the correct values
                //
                testContentBoxAttIsDiv : function () {
                    Y.Assert.areSame('DIV', wl2.docs.get('contentBox').get('nodeName'), 'contentBox should be div#docs');
                },
                testColumns0KeyEqualsDoc : function () {
                    Y.Assert.areSame('Doc', wl2.docs.get('columns')[0].key, 'wl2.docs.get("columns")[0].key should equal "Doc"');
                },
                testColumns0LabelEqualsDocid : function() {
                    Y.Assert.areSame('Docid',wl2.docs.get("columns")[0].label,'wl2.docs.get("columns")[0].label should equal "Docid"')
                },
                testColumns0SortableIsTrue : function () {
                    Y.Assert.isTrue(wl2.docs.get("columns")[0].sortable, 'docs.get("columns")[0].sortable indicates whether column can be sorted. Yes, in this case');
                },
                //
                //testing initialization of DocTable attributes by HTML_PARSER
                //
                testSourceTableHTMLParser : function () {
                    Y.Assert.isInstanceOf(Object, wl2.docs.get('sourceTable'), 'should be parsed during intialization');
                    Y.Assert.areSame('TABLE', wl2.docs.get('sourceTable').get('nodeName'), 'sourceTable should be a TABLE (the same table that is the contentBox, actually');
                },
                testSchemaFieldsHTMLParser : function () {
                    var contentBox = Y.get(wl2.cloneContentBox);
                    Y.Assert.isFunction(wl2.DocTable.HTML_PARSER.schemaFields, 'the schemaFields HTML_PARSER prop should be a function returning the field names from the <th>s');
                    Y.Assert.isArray(wl2.DocTable.HTML_PARSER.schemaFields(contentBox), 'schemaFields() should return the fields in an array');
                    Y.Assert.areSame(12, wl2.DocTable.HTML_PARSER.schemaFields(contentBox).length, 'there should be 12 fields');
                    Y.Assert.areSame('Doc', wl2.DocTable.HTML_PARSER.schemaFields(contentBox)[0].key, '"Doc" is the label (which should be used as the key) of the first column to be parsed into the ResponseSchema');
                    Y.Assert.areSame('string', wl2.DocTable.HTML_PARSER.schemaFields(contentBox)[0].parser, '"string" is the type embedded in the class "datatype-string" annotation (which should be used as the parser) of the first column to be parsed into the ResponseSchema');
                }
            });
            Y.wl2Tests.FirstTestCase = new Y.Test.Case({

                //the name of the test case - if not provided, one is automatically generated
                name: "First Tests",

                //setup is run before each test
                setUp : function () {
                },
                tearDown : function () {
                },
                _should: {
                    fail: {
                    },
                    error: {
                    },
                    ignore : {
                }
                },
                testConstants : function() {
                    Y.Assert.isString(wl2.TOGGLER_CLASS,"TOGGLER_CLASS: css class for toggler els, doubles as bubbling relay event label");
                    Y.Assert.isString(wl2.TOGGLEE_CLASS,'TOGGLEE_CLASS: css class for togglee els');
                    Y.Assert.isString(wl2.TOGGLER_ACTIVE_CLASS,'TOGGLER_ACTIVE_CLASS: css class for toggler els that have been turned on');
                    Y.Assert.isString(wl2.TOGGLEE_HIDDEN_CLASS,'TOGGLEE_HIDDEN_CLASS: css class for invisible togglee els');
                    Y.Assert.isString(wl2.TITLE_TOGGLER_CLASS,'TITLE_TOGGLER_CLASS: css class for toggler els controlling title els');
                    Y.Assert.isString(wl2.TOGGLE_COMPLETE,'TOGGLE_COMPLETE: bubbling relay event label for completed animation');
                    Y.Assert.isString(wl2.FAST_FADE_ANIM,'FAST_FADE_ANIM should be a string');
                    Y.Assert.isString(wl2.ANIMATE_HIDE,'ANIMATE_HIDE should be a string.');
                    Y.Assert.isString(wl2.ANIMATE_SHOW,'ANIMATE_SHOW should be a string.');
                    Y.Assert.isString(wl2.DOCTABLE_ID,'DOCTABLE_ID should be a string.');
                    Y.Assert.isString(wl2.CONTENT_BOX_SELECTOR,'CONTENT_BOX_SELECTOR: query string to locate our widget on the page, used when instantiating DocTable')
                    Y.Assert.isString(wl2.SCHEMA_FIELDS_SELECTOR, 'SCHEMA_FIELDS_SELECTOR: query string to find the fields for the datasource, searched for _within the CONTENT_BOX_ on instantiating the DocTable widget');
                    Y.Assert.isString(wl2.SOURCE_TABLE, 'SOURCE_TABLE: the HTML table for the DataSource to pull data from')
                },
                testWL2ResultDefined : function () {
                    Y.Assert.isNotUndefined(wl2.result, '"result" needs to be assigned to a property of the YUI instance so I can test if it has a success prop.');
                },
                testWL2LoadsOK : function () {
                    //FIXME: result returns success even when not all the modules given to use are
                    //loadable. What can make result not a success?
                    Y.Assert.isTrue(wl2.result.success, 'Load failure: ' + wl2.result.msg);
                },
                testModuleDependenciesSpecified : function () {
                    Y.Assert.isNotUndefined(wl2.DocTable, 'make sure to add "jao-doctable" to the "use" method');
                    Y.Assert.isNotUndefined(wl2.get, 'make sure to add "node" to the "use" method');
                    Y.Assert.isNotUndefined(wl2.Widget, 'make sure "jao-doctable" requires "widget"');
                    Y.Assert.isNotUndefined(YAHOO.widget.DataTable, 'got to load the modules to have a datatable');
                    Y.Assert.isNotUndefined(YAHOO.util.DataSource, 'got to load the modules to have a datasource for our datatable');
                },
                //
                // testing the DOM has the needed elements
                //
                testNeededElementsAreInDOM: function() {
                    var contentBoxNode = wl2.get(wl2.cloneContentBox);
                    Y.Assert.isNotNull(contentBoxNode, 'CONTENT_BOX_SELECTOR: the div to be the contentBox attr of the docTable instance');
                    Y.Assert.isNotNull(contentBoxNode.all(wl2.SCHEMA_FIELDS_SELECTOR), 'querying CONTENT_BOX_SELECTOR for SCHEMA_FIELDS_SELECTOR: the fields of our DataSource response schema');
                    Y.Assert.isNotNull(contentBoxNode.one(wl2.SOURCE_TABLE), 'querying CONTENT_BOX_SELECTOR for SOURCE_TABLE: the DOM element for our DataSource HTML table');
                },
                testDocTableInstance : function() {
                    Y.Assert.isInstanceOf(wl2.DocTable, wl2.docs, '"docs" should be an instance of DocTable.');
                }
            });


            //create the console
            //    var r = new Y.Console({
            //        verbose : true,
            //        newestOnTop : false
            //    });
            //
            //    r.render('#testLogger');

            Y.Test.Runner.add(Y.wl2Tests.FirstTestCase);
            Y.Test.Runner.add(Y.wl2Tests.DocTableInterface);
            Y.Test.Runner.add(Y.wl2Tests.DocTableImplementation);
            //run the tests
            Y.Test.Runner.run();
        });
    }
});
