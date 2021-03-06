'use strict';


angular.module('google-chart-sample').controller("FatChartCtrl",["$scope","$http", function ($scope, $http) {
    $(".chartContent h4").click(function(){
        $(".chartContent h4").removeClass("selected");
        $(this).addClass("selected");
    });

    $http.get('/dashboard/flight_vendor_data.json').success(function(data) {
        $scope.vendorChart1.data = data['flights_per_airline'];
        $scope.vendorChart1b.data = data['percentage_per_airline'];
        $scope.vendorChart2.data = data['flights_per_airline'];
        $scope.vendorChart2b.data = data['percentage_per_airline'];
        // $scope.vendorChart3.data = data['flights_per_airline'];


    }).error(function(error) {
        console.log('The file did not load');
    });

    $scope.report_type = "vendor";
    $scope.chart_number = 1;


    var vendorChart1 = {};
    vendorChart1.type = "PieChart";
    vendorChart1.displayed = false;
    vendorChart1.data = ([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

    vendorChart1.options = {
        "title": "Percentage of Flights per Airline",
        "isStacked": "true",
        "fill": 20,
        "displayExactValues": true,
        "vAxis": {
            "title": "Flights", "gridlines": {"count": 10}
        },
        "hAxis": {
            "title": "Airline"
        }
    };


   var vendorChart1b = {};
    vendorChart1b.type = "PieChart";
    vendorChart1b.displayed = false;
    vendorChart1b.data = ([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

    vendorChart1b.options = {
        "title": "Overall Spending per Airline",
        "isStacked": "true",
        "fill": 20,
        "displayExactValues": true,
        "vAxis": {
            "title": "Sales unit", "gridlines": {"count": 10}
        },
        "hAxis": {
            "title": "Date"
        }
    };



    var vendorChart2 = {};
    vendorChart2.type = "ColumnChart";
    vendorChart2.displayed = false;
    vendorChart2.data = ([
        ['Genre', 'Fantasy & Sci Fi', 'Romance', 'Mystery/Crime', 'General',
         'Western', 'Literature', { role: 'annotation' } ],
        ['2011', 10, 24, 20, 32, 18, 5, ''],
        ['2012', 16, 22, 23, 30, 16, 9, ''],
        ['2013', 28, 19, 29, 30, 12, 13, ''],
      ]);

    vendorChart2.options = {
        "title": "Flights per Airline",
        "isStacked": "true",
        "fill": 20,
        "displayExactValues": true,
        "vAxis": {
            "title": "Flights", "gridlines": {"count": 10}
        },
        "hAxis": {
            "title": ""
        }
    };

    var vendorChart2b = {};
    vendorChart2b.type = "BarChart";
    vendorChart2b.displayed = false;
    vendorChart2b.data = ([
        ['American', 'United', 'Delta', 'Fronteir', 'US Airways',
         'Airtran', 'Alaska', { role: 'annotation' } ],
        ['2011', 10, 24, 20, 32, 18, 5, ''],
        ['2012', 16, 22, 23, 30, 16, 9, ''],
        ['2013', 28, 19, 29, 30, 12, 13, ''],
      ]);

    vendorChart2b.options = {
        "title": "Flights Per Top Airline",
        "isStacked": "true",
        "fill": 20,
        "displayExactValues": true,
        "vAxis": {
            "title": "Sales unit", "gridlines": {"count": 10}
        },
        "hAxis": {
            "title": "Date"
        }
    };


   var vendorChart3 = {};
    vendorChart3.type = "BarChart";
    vendorChart3.displayed = false;
    vendorChart3.data = ([
        ['American', 'United', 'Delta', 'Fronteir', 'US Airways',
         'Airtran', 'Alaska', { role: 'annotation' } ],
        ['2011', 2345, 1543, 950, 820, 780, 50, ''],
        ['2012', 2500, 1685, 930, 800, 660, 40, ''],
        ['2013', 3000, 1894, 990, 800, 520, 130, ''],
      ]);

    vendorChart3.options = {
        "title": "Flights per Top Airlines",
        "isStacked": "true",
        "fill": 20,
        "displayExactValues": true,
        "vAxis": {
            "title": "", "gridlines": {"count": 10}
        },
        "hAxis": {
            "title": "Flights"
        }
    };


   var priceChart1 = {};
    priceChart1.type = "LineChart";
    priceChart1.displayed = false;
    priceChart1.data = ([
        ['Country',   'Population', 'Area Percentage'],
        ['France',  65700000, 50],
        ['Germany', 81890000, 27],
        ['Poland',  38540000, 23],
      ]);

    priceChart1.options = {
        "title": "Sales per month",
        "isStacked": "true",
        "fill": 20,
        "displayExactValues": true,
        "vAxis": {
            "title": "Sales unit", "gridlines": {"count": 10}
        },
        "hAxis": {
            "title": "Date"
        }
    };


    $scope.vendorChart1 = vendorChart1;
    $scope.vendorChart1b = vendorChart1b;
    $scope.vendorChart2 = vendorChart2;
    $scope.vendorChart2b = vendorChart2b;

    $scope.vendorChart3 = vendorChart3;
    $scope.priceChart1 = priceChart1;

    // <option value="AreaChart">AreaChart</option>
    // <option value="PieChart">PieChart</option>
    // <option value="ColumnChart">ColumnChart</option>
    // <option value="LineChart">LineChart</option>
    // <option value="Table">Table</option>
    // <option value="BarChart">BarChart</option>

    $scope.cssStyle = "width:600px; height:300px;";
    $scope.cssStyle1 = "width:300px;";
    $scope.cssStyle2 = "width:100%; height:500px;";

    $scope.reportTypeChange = function (report) {
        $scope.report_type = report;
    }

    $scope.updateChartNumber = function (chartNumber) {
        $scope.chart_number = chartNumber;
    }


}]);



