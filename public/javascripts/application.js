  /* Create an array with the values of all the select options in a column */
  jQuery.fn.dataTableExt.afnSortData['dom-select'] = function  ( oSettings, iColumn )
{
	var aData = [];
	jQuery( 'td:not(.field-list td):eq('+iColumn+') select', oSettings.oApi._fnGetTrNodes(oSettings) ).each( function () {
          aData.push(jQuery(this).val());
	} );
	return aData;
}
// load the dataTables table
jQuery(document).ready(function() {

	jQuery('.display > table').dataTable( {
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
			{ "sSortDataType": "dom-select" } //workstate
		]
	} );
} );