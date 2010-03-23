jQuery(document).ready(function($) {
  //put some config in my wl2 namespace
  $.wl2 = {
    ooColumns : {
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
    },
    sTableSelector : 'table.display'
  };
  $.wl2.initInputHeaders = function() {
    var headers = jQuery(' tr.field-heading-row > th') || [];
    return headers;
  };
  /* For live sorting, create an array with the values of all the select options in a column read from the DOM*/
  $.fn.dataTableExt.afnSortData['dom-select'] = function  ( oSettings, iColumn )
  {
    var aData = [];
    $( 'td:not(.field-list td):eq('+iColumn+') select', oSettings.oApi._fnGetTrNodes(oSettings) ).each( function () {
      aData.push($(this).val());
    } );
    return aData;
  }
  // insert dummy links into table headers for clicking in tests
  $('table.display > thead > tr > th').each(function() {
    var sAnchor = '<a href="javascript:void(null)">' + $.trim($(this).text()) + '</a>';
    $(this).html(sAnchor);
  })
  // load the dataTables table
  $('table.display').dataTable( {
    'aoColumns': [
    {
      sType: 'html'
    }, //docid

    {
      sType: 'html'
    }, //titles
    null, //approveddate, autodetected
    null, //modifieddate, autodetected
    {
      sType: 'html'
    }, //domains
    null, //owner
    null, //visibility
    {
      sType: 'html'
    },//tags

    {
      sType: 'html'
    },//notes

    {
      "sSortDataType": "dom-select"
    }, //workstate
    ]
  } );
} );