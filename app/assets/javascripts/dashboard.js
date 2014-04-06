var ready;
ready = function() {

function fnFormatDetails ( oTable, tmpTr)
{
    var aData = oTable.fnGetData( tmpTr );
    var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px; border:2px solid #333; width:100%; background-color:#87CEEB;">';
    sOut += '<tr><td>Ticket Number:</td><td>' + aData[9] + '</td></tr>';
    sOut += '<tr><td>Online Indicator:</td><td>' + aData[10] + '</td></tr>';
    sOut += '<tr><td>Mileage:</td><td>' + aData[11] + '</td></tr>';
    sOut += '<tr><td>Routing:</td><td>' + aData[12] + '</td></tr>';
    sOut += '<tr><td>Domestic/International:</td><td>' + aData[13] + '</td></tr>';
    sOut += '<tr><td>Trip Departure Date:</td><td>' + aData[14] + '</td></tr>';
    sOut += '<tr><td>Reservation Date:</td><td>' + aData[15] + '</td></tr>';
    sOut += '<tr><td style="colspan:2"><a href="#">Exclude this Transaction</a></td></tr>';

    sOut += '</table>';

    return sOut;
}

    /*
     * Initialse DataTables, with no sorting on the 'details' column
     */

    filterStartDate = moment().subtract('days', 29).format('D/M/YYYY');
    filterEndDate = moment().format('D/M/YYYY');

    var oTable = $('#flight_reservations').dataTable( {
        sPaginationType: "full_numbers",
        iDisplayLength: 25,
        aLengthMenu: [[25, 50, 100], [25, 50, 100]],
        bJQueryUI: true,
        bProcessing: true,
        bServerSide: true,
        aoColumns:[null,null,null,null,null,null,null,null, {"bSearchable": false, "bVisible":    false },{"bSearchable": false, "bVisible":    false },{"bSearchable": false, "bVisible":    false },{"bSearchable": false, "bVisible":    false },{"bSearchable": false, "bVisible":    false },{"bSearchable": false, "bVisible":    false },{"bSearchable": false, "bVisible":    false },{"bSearchable": false, "bVisible":    false }],
        sDom: "T<'clear'>lfrtip",
        oTableTools: {
            "sSwfPath": "media/swf/copy_csv_xls_pdf.swf"
        },
        sAjaxSource:$('#flight_reservations').data('source'),
        fnServerData: function ( sSource, aoData, fnCallback ) {
            /* Add some extra data to the sender */

                aoData.push( { "name": "start_date", "value": filterStartDate } );
                aoData.push( { "name": "end_date", "value": filterEndDate } );
            $.getJSON( sSource, aoData, function (json) {
                 // Do whatever additional processing you want on the callback, then tell DataTables
                fnCallback(json);
                // alert('ajax call ran');
            } );
        },
        fnRowCallback: function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            var sDirectionClass;
            if ( aData[8] > 20 )
                sDirectionClass = "outlierSaver";
            else if ( aData[8] < -20 )
                sDirectionClass = "outlierSpender";
            else
                sDirectionClass = "nonOutlier";

            $(nRow).addClass( sDirectionClass );
            return nRow;
            }
    });

    /* Add event listener for opening and closing details
     * Note that the indicator for showing which row is open is not controlled by DataTables,
     * rather it is done here
     */
    $('#flight_reservations tbody').on('click','tr', function () {
        var tmpTr = $(this)[0];

        if(oTable.fnIsOpen(tmpTr)){
            $("td img",tmpTr).attr("src","http://datatables.net/release-datatables/examples/examples_support/details_open.png");
            oTable.fnClose( tmpTr );
        } else{
            oTable.fnOpen(tmpTr, fnFormatDetails(oTable, tmpTr));
            $("td img",tmpTr).attr("src","http://datatables.net/release-datatables/examples/examples_support/details_close.png");
        }

    });

    /* Table on Dashboard homepage */
    var overviewTable = $('#department_overview').dataTable( {
        sPaginationType: "full_numbers",
        bProcessing: true,
        bServerSide: true,
        bJQueryUI: false,
        bFilter: false,
        bPaginate: false,
        bInfo: false,
        sAjaxSource:$('#department_overview').data('source'),
    });

    $('#reportrange').daterangepicker(
        {
          ranges: {
             // 'Today': [moment(), moment()],
             // 'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
             // 'Last 7 Days': [moment().subtract('days', 6), moment()],
            'Sept 30 2010': [moment('9/30/2010').startOf('day'), moment('9/30/2010').endOf('day')],
             'Last 30 Days': [moment().subtract('days', 29), moment()],
             'This Month': [moment().startOf('month'), moment().endOf('month')],
             'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')],
             'This Year': [moment().startOf('year'), moment()],
             'Last Year': [moment().subtract('month',12).startOf('year'), moment().subtract('month',12).endOf('year')]
          },
          startDate: moment().subtract('days', 29),
          endDate: moment()
        },
        function(start, end, aoData) {
            $('#reportrange span').html(start.format('MMM D, YYYY') + ' - ' + end.format('MMM D, YYYY'));
            // alert(start.format('MMM D, YYYY') + ' - ' + end.format('MMM D, YYYY'));
            oTable.fnClearTable();
            filterStartDate = start.format('D/M/YYYY');
            filterEndDate = end.format('D/M/YYYY');

            // oTable.fnSettings().aoData.push({"name": 'start_date', "value":'27/9/2010'});
            oTable.fnDraw();
        }
    );

};

$(document).ready(ready);
$(document).on('page:load', ready);
