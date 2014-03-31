var ready;
ready = function() {
$('#flight_reservations').dataTable( {
        sPaginationType: "full_numbers",
        iDisplayLength: "200",
        bJQueryUI: true,
        bProcessing: true,
        bServerSide: true,
        sAjaxSource:$('#flight_reservations').data('source')
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);
