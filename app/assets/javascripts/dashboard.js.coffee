# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
        $('#flight_reservations').dataTable(sPaginationType: "full_numbers", iDisplayLength: "200",bJQueryUI: true,bProcessing: true,bServerSide: true,sAjaxSource:$('#flight_reservations').data('source'))
