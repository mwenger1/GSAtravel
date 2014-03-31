var ready;
ready = function() {

function fnFormatDetails ( oTable, tmpTr)
{
    var aData = oTable.fnGetData( tmpTr );
    var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px; border:2px solid #333; width:100%; background-color:#ccc;">';
    sOut += '<tr><td>Transaction Info:</td><td>' + aData[2] + '</td></tr>';
    sOut += '<tr><td>Link to source:</td><td>Could provide a link here</td></tr>';
    sOut += '<tr><td>Extra info:</td><td>And any further details here (images etc)</td></tr>';
    sOut += '</table>';

    return sOut;
}

    /*
     * Initialse DataTables, with no sorting on the 'details' column
     */
    var oTable = $('#flight_reservations').dataTable( {
        sPaginationType: "full_numbers",
        iDisplayLength: 25,
        aLengthMenu: [[25, 50, 100], [25, 50, 100]],
        bJQueryUI: true,
        bProcessing: true,
        bServerSide: true,
        aoColumns:[null,null,null,null,null,null,null,null, {"bSearchable": false, "bVisible":    false }],
        sDom: "T<'clear'>lfrtip",
        oTableTools: {
            "sSwfPath": "media/swf/copy_csv_xls_pdf.swf"
        },
        sAjaxSource:$('#flight_reservations').data('source'),
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

        // tmpImage = $("td img",this).attr('src');
        // console.log(tmpImage);
        var tmpTr = $(this)[0];

        if(oTable.fnIsOpen(tmpTr)){
            $("td img",tmpTr).attr("src","http://datatables.net/release-datatables/examples/examples_support/details_open.png");
            oTable.fnClose( tmpTr );
        } else{
            oTable.fnOpen(tmpTr, fnFormatDetails(oTable, tmpTr));
            $("td img",tmpTr).attr("src","http://datatables.net/release-datatables/examples/examples_support/details_close.png");
        }

        // if ( oTable.fnIsOpen(nTr) )
        // {
        //     /* This row is already open - close it */
        //     this.src = "http://datatables.net/release-datatables/examples/examples_support/details_open.png";
        //     oTable.fnClose( nTr );
        //     console.log('this ran');
        // }
        // else
        // {
        //     /* Open this row */
        //     this.src = "http://datatables.net/release-datatables/examples/examples_support/details_close.png";
        //     oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
        //     console.log('that ran');
        // }
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);
