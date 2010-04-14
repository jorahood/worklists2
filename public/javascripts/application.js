jQuery(document).ready(function($) {
  //put some config in my wl2 namespace

  var ooColumns = {
    Docid: {
      sType: 'html'
    },
    Titles: {
      sType: 'html'
    },
    Approveddate: {
      sType: 'date'
    },
    Modifieddate: {
      sType: 'date'
    },
    Birthdate: {
      sType: 'date'
    },
    Domains: {
      sType: 'html'
    },
    Owner: {
      sType: 'html'
    },
    Author: {
      sType: 'html'
    },
    Refs: {
      sType: 'html'
    },
    Refbys: {
      sType: 'html'
    },
    "Boiler Name": {
      sType: 'html'
    },
    "Referenced Boilers": {
      sType: 'html'
    },
    Expirations: {
      sType: 'html'
    },
    Hotitems: {
      sType: 'html'
    },
    Importance: {
      sType: 'html'
    },
    Resources: {
      sType: 'html'
    },
    Status: {
      sType: 'html'
    },
    Visibility: {
      sType: 'html'
    },
    Volatility: {
      sType: 'html'
    },
    Kbas: {
      sType: 'html'
    },
    "Kba Bys": {
      sType: 'html'
    },
    Xtras: {
      sType: 'html'
    },
    Tags: {
      sSortDataType: 'dom-html'
    },
    Notes: {
      sSortDataType: 'dom-html'
    },
    Workstate: {
      sSortDataType: "dom-select" // see $.fn.dataTableExt.afnSortData['dom-select']
    }
  };
  var sTableSelector = 'off';//'table.display';
  var sHeadersSelector = sTableSelector + ' tr.field-heading-row > th';
  var sUnNestedTdSelector = 'td:not(.field-list td)';
  //* create the aoColumns array to initialize the dataTable with
  var afnInitColumns = function() {
    var aFields = [];
    //iterate over the header nodes to build the responseSchema fields
    $(sHeadersSelector).each ( function( index, el ){
      var label = $(el).text() //use the text inside the anchor in each <th> as the label for each field
      aFields.push(
        ooColumns[label]
        );
    });
    return aFields;
  };
  // see "Custom data source sorting" on http://www.datatables.net/plug-ins/sorting for more examples of the
  // below custom sorting functions
  $.fn.dataTableExt.afnSortData['dom-select'] = function  ( oSettings, iColumn ) {
    var aData = [];
    $( sUnNestedTdSelector + ':eq('+iColumn+') select', oSettings.oApi._fnGetTrNodes(oSettings) ).each( 
      function (index, el) {
        var value = $(el).val();
        aData.push(value);
      } );
    return aData;
  };
  $.fn.dataTableExt.afnSortData['dom-html'] = function ( oSettings, iColumn ) {
    var aData = [];
    $( sUnNestedTdSelector + ':eq('+iColumn+')', oSettings.oApi._fnGetTrNodes(oSettings) ).each(
      function (index, el) {
        var text = $(el).text();
        aData.push(text);
//        if (text) {console.log(text);}
      });
      return aData;
  };
  // wrap the text in headers in dummy links for clicking in tests
  $(sHeadersSelector).each(function(index, el) {
    var sAnchor = '<a href="javascript:void(null)">' + $.trim($(el).text()) + '</a>';
    $(el).html(sAnchor);
  })
  // load the dataTables table
  $('table.display').dataTable( {
    'aoColumns': afnInitColumns()
  } );
} );