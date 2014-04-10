'use strict';


angular.module('google-chart-sample').controller("FatChartCtrl",["$scope","$http", function ($scope, $http) {

    $http.get('/dashboard/flight_vendor_data.json').success(function(data) {
        $scope.vendorChart1.data = data['flights_per_airline'];
        $scope.vendorChart1b.data = data['percentage_per_airline'];
        $scope.vendorChart2.data = data['flights_per_airline'];
        $scope.vendorChart2b.data = data['percentage_per_airline'];

    $scope.vendorChart2b = vendorChart2;

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
            "title": "Sales unit", "gridlines": {"count": 10}
        },
        "hAxis": {
            "title": "Date"
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
        ['2010', 10, 24, 20, 32, 18, 5, ''],
        ['2020', 16, 22, 23, 30, 16, 9, ''],
        ['2030', 28, 19, 29, 30, 12, 13, ''],
      ]);

    vendorChart2.options = {
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

    var vendorChart2b = {};
    vendorChart2b.type = "ColumnChart";
    vendorChart2b.displayed = false;
    vendorChart2b.data = ([
        ['Genre', 'Fantasy & Sci Fi', 'Romance', 'Mystery/Crime', 'General',
         'Western', 'Literature', { role: 'annotation' } ],
        ['2010', 10, 24, 20, 32, 18, 5, ''],
        ['2020', 16, 22, 23, 30, 16, 9, ''],
        ['2030', 28, 19, 29, 30, 12, 13, ''],
      ]);

    vendorChart2b.options = {
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


   var vendorChart3 = {};
    vendorChart3.type = "BarChart";
    vendorChart3.displayed = false;
    vendorChart3.data = ([
        ['Genre', 'Fantasy & Sci Fi', 'Romance', 'Mystery/Crime', 'General',
         'Western', 'Literature', { role: 'annotation' } ],
        ['2010', 10, 24, 20, 32, 18, 5, ''],
        ['2020', 16, 22, 23, 30, 16, 9, ''],
        ['2030', 28, 19, 29, 30, 12, 13, ''],
      ]);

    vendorChart3.options = {
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


    $scope.cssStyle = "height:600px; width:100%;";

    $scope.reportTypeChange = function (report) {
        $scope.report_type = report;
    }

    $scope.updateChartNumber = function (chartNumber) {
        $scope.chart_number = chartNumber;
    }


}]);



