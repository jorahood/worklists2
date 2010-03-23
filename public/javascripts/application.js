  /* Create an array with the values of all the select options in a column */
  jQuery.fn.dataTableExt.afnSortData['dom-select'] = function  ( oSettings, iColumn )
{
	var aData = [];
	jQuery( 'td:not(.field-list td):eq('+iColumn+') select', oSettings.oApi._fnGetTrNodes(oSettings) ).each( function () {
          aData.push(jQuery(this).val());
	} );
	return aData;
}
// insert dummy links into table headers for clicking in tests
jQuery(document).ready(function() {
        jQuery('table.display > thead > tr > th').each(function() {
          var sAnchor = '<a href="javascript:void(null)">' + jQuery.trim(jQuery(this).text()) + '</a>';
          jQuery(this).html(sAnchor);
        })
// load the dataTables table
	jQuery('table.display').dataTable( {
		'aoColumns': [
			{sType: 'html'}, //docid
			{sType: 'html'}, //titles
			null, //approveddate, autodetected
			null, //modifieddate, autodetected
			{sType: 'html'}, //domains
                        null, //owner
                        null, //visibility
                        {sType: 'html'},//tags
			{ sType: 'html' },//notes
			{ "sSortDataType": "dom-select" }, //workstate
		]
	} );
} );