var ready;
ready = function() {

    function fnFormatFlightDetails(oTable, tmpTr) {
        var aData = oTable.fnGetData(tmpTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="float:left;padding: 5px; border-collapse: separate; border-spacing: 15px 4px;">';
            sOut += '<tr><td><strong>Ticket Number:</strong></td><td>' + aData[10] + '</td>';
            sOut += '<td><strong>Cabin Type:</strong></td><td>' + aData[17] + '</td></tr>';
            sOut += '<tr><td><strong>Purchase Date:</strong></td><td>' + aData[14] + '</td>';
            sOut += '<td><strong>Distance:</strong></td><td>' + aData[11] + '</td></tr>';
            sOut += '<tr><td><strong>Route: </strong></td><td><span class="airportCode btn btn-default" data-container="body" data-toggle="popover" data-placement="top" >' + aData[15] + '</span>  to  <span class="airportCode btn btn-default" data-container="body" data-toggle="popover" data-placement="top" >' + aData[16] + '</span></td>';
            sOut += '<td><strong>Cost Per Mile:</strong></td><td>' + aData[18] + ' (site average = $7.25)</td></tr>';

            sOut += '<tr><td><strong>Full Trip Itinerary:</strong></td><td>' + aData[12] + '</td><td></td></tr>';
            sOut += '</table>';
            sOut += '<a target="_blank" href="http://www.kayak.com/flights/' + aData[15] + '-' + aData[16] + '/' + moment().add(59,"d").format('YYYY-MM-DD') + '/' + moment().add(63,"d").format('YYYY-MM-DD') + '" class="btn" style="background-color: #fff; float: right; margin: 10px 15px;box-shadow: 0px 1px 1px grey;">Compare on Kayak</a>';
            sOut += '<a href="#" class="btn" style="background-color: #fff; float: right; margin: 10px 15px;box-shadow: 0px 1px 1px grey;">Exclude this Transaction</a>';
        return sOut;
    }

    function fnFormatHotelDetails(oTable, tmpTr) {
        var aData = oTable.fnGetData(tmpTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="float:left;padding: 5px; border-collapse: separate; border-spacing: 15px 4px;">';
            sOut += '<tr class="nonClickable"><td>Ticket Number:</td><td>' + aData[10] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td>Hotel Address:</td><td>' + aData[16] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td>Property Name:</td><td>' + aData[14] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td>Distance:</td><td>' + aData[11] + ' miles</td></tr>';
            sOut += '<tr class="nonClickable"><td>Cost Per Mile:</td><td>$5.23 (site average = $7.25)</td></tr>';
            sOut += '<tr class="nonClickable"><td>Final Destination:</td><td>From:<span class="airportCode btn btn-default" data-container="body" data-toggle="popover" data-placement="top" >' + aData[15] + '</span> to: <span class="airportCode btn btn-default" data-container="body" data-toggle="popover" data-placement="top" >' + aData[16] + '</span></td></tr>';
            sOut += '<tr class="nonClickable"><td>Full Trip Itinerary:</td><td>' + aData[12] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td style="colspan:2"><a href="#">Exclude this Transaction</a></td></tr>';

            sOut += '</table>';
        return sOut;
    }

    function fnFormatCarRentalDetails(oTable, tmpTr) {
        var aData = oTable.fnGetData(tmpTr);
            var sOut = '<table cellpadding="5" cellspacing="0" border="0" style="float:left;padding: 5px; border-collapse: separate; border-spacing: 15px 4px;">';
            sOut += '<tr class="nonClickable"><td>Ticket Number:</td><td>' + aData[10] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td>Cabin Type:</td><td>' + aData[16] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td>Purchase Date:</td><td>' + aData[14] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td>Dates of Rental:</td><td>From: ' + aData[11] + ' to ' + aData[12] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td>Cost Per Mile:</td><td>$5.23 (site average = $7.25)</td></tr>';
            sOut += '<tr class="nonClickable"><td>Pick Up Location:</td><td>From:<span class="airportCode btn btn-default" data-container="body" data-toggle="popover" data-placement="top" >' + aData[15] + '</span> to: <span class="airportCode btn btn-default" data-container="body" data-toggle="popover" data-placement="top" >' + aData[16] + '</span></td></tr>';
            sOut += '<tr class="nonClickable"><td>Drop Off Location:</td><td>' + aData[12] + '</td></tr>';
            sOut += '<tr class="nonClickable"><td style="colspan:2"><a href="#">Exclude this Transaction</a></td></tr>';

            sOut += '</table>';
        return sOut;
    }

    function checkPopups(){
        $('*[data-toggle]').on('click',function(e) {
            $('.popover').popover('hide');
            var e=$(this);
            $.getJSON("/dashboard/airport_api?airport_code=" + e.text().trim(), function(data){
                e.popover({title: data['airports'][0]['name'], content: data['airports'][0]['city'] + ", " + data['airports'][0]['country']}).popover('show');
            });
        });
    }



    filterStartDate = moment('1/1/2010').format('D/M/YYYY');
    filterEndDate = moment().format('D/M/YYYY');
    eventTypeFilter = "flight";
    checkPopups();
    var oTable1 = $('#flight_reservations').dataTable({
        iDisplayLength: 25,
        aLengthMenu: [
            [25, 50, 100],
            [25, 50, 100]
        ],
        bJQueryUI: true,
        bServerSide: true,
        aoColumns: [null, { "sWidth": "120px" }, { "sWidth": "110px" }, { "sWidth": "160px" }, { "sWidth": "180px" }, { "sWidth": "30px" }, null, null, null, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
              }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }],
        sDom: '<if>rt<"tableFooterBuffer"><lp><"clear">',
        sPaginationType: "full_numbers",

        oTableTools: {
            sSwfPath: "media/swf/copy_csv_xls_pdf.swf"
        },
        oLanguage: {
            sInfo: "Showing (_START_ to _END_) of _TOTAL_ transactions",
            sInfoEmpty: "No transactions match this search.<br>Expand your filters or <a href='/import/index' >upload transaction data</a>."
        },
        sAjaxSource: $('#flight_reservations').data('source'),
        fnServerData: function(sSource, aoData, fnCallback) {
            /* Add some extra data to the sender */
            aoData.push({
                "name": "transaction_type",
                "value": eventTypeFilter
            });
            aoData.push({
                "name": "start_date",
                "value": filterStartDate
            });
            aoData.push({
                "name": "end_date",
                "value": filterEndDate
            });
            $.getJSON(sSource, aoData, function(json) {
                // Do whatever additional processing you want on the callback, then tell DataTables
                fnCallback(json);
                // alert('ajax call ran');
            });
        },
        fnRowCallback: function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            var sDirectionClass;
            sDirectionClass = "clickableTableRow";
            $(nRow).addClass(sDirectionClass);
            var number = Number(aData[8].replace(/[^-?0-9\.]+/g,""));
            if ( number > 0)
                sDirectionClass = "saver";
            else if (number < 0)
                sDirectionClass = "spender";
            else
                sDirectionClass = "";

            $(nRow).addClass(sDirectionClass);

        }
    });

    var oTable2 = $('#hotel_reservations').dataTable({
        iDisplayLength: 25,
        aLengthMenu: [
            [25, 50, 100],
            [25, 50, 100]
        ],
        bJQueryUI: true,
        bServerSide: true,
        aoColumns: [null, null, null, null, null, null, null, null, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }],
        sDom: '<if>rt<"tableFooterBuffer"><lp><"clear">',
        sPaginationType: "full_numbers",

        oTableTools: {
            sSwfPath: "media/swf/copy_csv_xls_pdf.swf"
        },
        oLanguage: {
            sInfo: "Showing (_START_ to _END_) of _TOTAL_ transactions",
            sInfoEmpty: "No transactions match this search.<br>Expand your filters or <a href='/import/index' >upload transaction data</a>."
        },
        sAjaxSource: $('#hotel_reservations').data('source'),
        fnServerData: function(sSource, aoData, fnCallback) {
            /* Add some extra data to the sender */
            aoData.push({
                "name": "transaction_type",
                "value": eventTypeFilter
            });
            aoData.push({
                "name": "start_date",
                "value": filterStartDate
            });
            aoData.push({
                "name": "end_date",
                "value": filterEndDate
            });
            $.getJSON(sSource, aoData, function(json) {
                // Do whatever additional processing you want on the callback, then tell DataTables
                fnCallback(json);
                // alert('ajax call ran');
            });
        },
        fnRowCallback: function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            var sDirectionClass;
            sDirectionClass = "clickableTableRow";
            $(nRow).addClass(sDirectionClass);
        }
    });

        var oTable3 = $('#car_rental_reservations').dataTable({
        iDisplayLength: 25,
        aLengthMenu: [
            [25, 50, 100],
            [25, 50, 100]
        ],
        bJQueryUI: true,
        bServerSide: true,
        aoColumns: [null, null, null, null, null, null, null, null, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }, {
            "bSearchable": false,
            "bVisible": false
        }],
        sDom: '<if>rt<"tableFooterBuffer"><lp><"clear">',
        sPaginationType: "full_numbers",

        oTableTools: {
            sSwfPath: "media/swf/copy_csv_xls_pdf.swf"
        },
        oLanguage: {
            sInfo: "Showing (_START_ to _END_) of _TOTAL_ transactions",
            sInfoEmpty: "No transactions match this search.<br>Expand your filters or <a href='/import/index' >upload transaction data</a>."
        },
        sAjaxSource: $('#car_rental_reservations').data('source'),
        fnServerData: function(sSource, aoData, fnCallback) {
            /* Add some extra data to the sender */
            aoData.push({
                "name": "transaction_type",
                "value": eventTypeFilter
            });
            aoData.push({
                "name": "start_date",
                "value": filterStartDate
            });
            aoData.push({
                "name": "end_date",
                "value": filterEndDate
            });
            $.getJSON(sSource, aoData, function(json) {
                // Do whatever additional processing you want on the callback, then tell DataTables
                fnCallback(json);
                // alert('ajax call ran');
            });
        },
        fnRowCallback: function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            var sDirectionClass;
            sDirectionClass = "clickableTableRow";
            $(nRow).addClass(sDirectionClass);
        }
    });

    /* Add event listener for opening and closing details
     * Note that the indicator for showing which row is open is not controlled by DataTables,
     * rather it is done here
     */
    $('#flight_reservations tbody[role="alert"]').on('click', 'tr.clickableTableRow', function() {
        var tmpTr = $(this)[0];
        if (oTable1.fnIsOpen(tmpTr)) {
            $("td img", tmpTr).attr("src", "http://datatables.net/release-datatables/examples/examples_support/details_open.png");
            oTable1.fnClose(tmpTr);
            $(this).removeClass('active');
        } else {
            oTable1.fnOpen(tmpTr, fnFormatFlightDetails(oTable1, tmpTr));
            $("td img", tmpTr).attr("src", "http://datatables.net/release-datatables/examples/examples_support/details_close.png");
            $(this).addClass('active');
            checkPopups();
        }
    });

    $('#hotel_reservations tbody[role="alert"]').on('click', 'tr.clickableTableRow', function() {
        var tmpTr = $(this)[0];
        if (oTable2.fnIsOpen(tmpTr)) {
            $("td img", tmpTr).attr("src", "http://datatables.net/release-datatables/examples/examples_support/details_open.png");
            oTable2.fnClose(tmpTr);
            $(this).removeClass('active');
        } else {
            oTable2.fnOpen(tmpTr, fnFormatHotelDetails(oTable2, tmpTr));
            $("td img", tmpTr).attr("src", "http://datatables.net/release-datatables/examples/examples_support/details_close.png");
            $(this).addClass('active');

        }
    });

    $('#car_rental_reservations tbody[role="alert"]').on('click', 'tr.clickableTableRow', function() {
        var tmpTr = $(this)[0];
        if (oTable3.fnIsOpen(tmpTr)) {
            $("td img", tmpTr).attr("src", "http://datatables.net/release-datatables/examples/examples_support/details_open.png");
            oTable3.fnClose(tmpTr);
            $(this).removeClass('active');
        } else {
            oTable3.fnOpen(tmpTr, fnFormatCarRentalDetails(oTable3, tmpTr));
            $("td img", tmpTr).attr("src", "http://datatables.net/release-datatables/examples/examples_support/details_close.png");
            $(this).addClass('active');
        }
    });


    /* Table on Dashboard homepage */
    var overviewTable = $('#department_overview').dataTable({
        sPaginationType: "full_numbers",
        bServerSide: true,
        bJQueryUI: false,
        bFilter: false,
        bPaginate: false,
        bInfo: false,
        sAjaxSource: $('#department_overview').data('source'),
    });

    $('#reportrange').daterangepicker({
            ranges: {
                'All Time': [moment('1/1/2010'), moment()],
                '&nbsp;2014': [moment('1/1/2014'), moment('1/1/2014').endOf('year')],
                '&nbsp;2013': [moment('1/1/2013'), moment('1/1/2013').endOf('year')],
                '&nbsp;2012': [moment('1/1/2012'), moment('1/1/2012').endOf('year')],
                '&nbsp;2011': [moment('1/1/2011'), moment('1/1/2011').endOf('year')],
                '&nbsp;2010': [moment('1/1/2010'), moment('1/1/2010').endOf('year')],
                '&nbsp;2009': [moment('1/1/2009'), moment('1/1/2009').endOf('year')]


            },
            startDate: moment().subtract('days', 20),
            endDate: moment().subtract('days', 10)
        },
        function(start, end, aoData) {
            $('#reportrange span').html(start.format('MMM D, YYYY') + ' - ' + end.format('MMM D, YYYY'));
            oTable1.fnClearTable();
            oTable2.fnClearTable();
            oTable3.fnClearTable();

            filterStartDate = start.format('D/M/YYYY');
            filterEndDate = end.format('D/M/YYYY');

            // oTable.fnSettings().aoData.push({"name": 'start_date', "value":'27/9/2010'});
            oTable1.fnDraw();
            oTable2.fnDraw();
            oTable3.fnDraw();
        }
    );

    $('#transcationTypeFilter button').click(function() {
        $("#transcationTypeFilter button").removeClass("active");
        $(this).addClass("active");
        oTable1.fnClearTable();
        oTable2.fnClearTable();
        oTable3.fnClearTable();
        oTable1.fnDraw();
        oTable2.fnDraw();
        oTable3.fnDraw();
        eventTypeFilter = $(this).data('filter');
        $("#transactionsHeader").text(eventTypeFilter + " Transactions");

        var tmpFilter = (eventTypeFilter == "Car Rental")?"car_rental":eventTypeFilter.toLowerCase();
        var tmpName = "#" + tmpFilter + "_reservations_wrapper";
        $("#tablesWrapper .dataTables_wrapper").hide();
        $(tmpName).show();
    });

    $('#franchise').show();
    $('.trendOptions h4').click(function(){
        $('.glyphicon .glyphicon-chevron-down').addClass('glyphicon glyphicon-chevron-up');
        $('.glyphicon .glyphicon-chevron-down').removeClass('glyphicon glyphicon-chevron-down');
    });
    $('.franchise').click(function(){
        $('#franchise').show();
        $('#pricePerMile').hide();
        $('#hotspots').hide();
        $('#days').hide();
    });
    $('.pricePerMile').click(function(){
        $('#pricePerMile').show();
        $('#hotspots').hide();
        $('#days').hide();
        $('#franchise').hide();
    });
    $('.hotspots').click(function(){
        $('#hotspots').show();
        $('#days').hide();
        $('#franchise').hide();
        $('#pricePerMile').hide();
    });
    $('.days').click(function(){
        $('#days').show();
        $('#franchise').hide();
        $('#pricePerMile').hide();
        $('#hotspots').hide();
    });
    $('#chart').show();
    $('#price_piechart').hide();
    $('#scatterchart').show();
    $('#barchart').show();
    $('#geochart').show();
    $('#franchise .flights_amount').click(function(){
        $('#chart').show();
        $('#price_piechart').hide();
        $('#scatterchart').hide();
        $('#barchart').hide();
    });
    $('#franchise .flights_cost').click(function(){
        $('#chart').hide();
        $('#price_piechart').show();
        $('#scatterchart').hide();
        $('#barchart').hide();
    });

};




$(document).ready(ready);
$(document).on('page:load', ready);


