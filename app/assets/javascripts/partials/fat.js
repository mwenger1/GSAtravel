'use strict';

angular.module('google-chart-sample').controller("FatChartCtrl",["$scope","$http", function ($scope, $http) {

    $http.get('/dashboard/flight_vendor_data.json').success(function(data) {
        $scope.items = data;
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


    var vendorChart2 = {};
    vendorChart2.type = "ColumnChart";
    vendorChart2.displayed = false;
    vendorChart2.data = ([
    ['Element', 'Density', { role: 'style' }],
        ['Copper', 8.94, '#b87333'],            // RGB value
    ['Silver', 10.49, 'silver'],            // English color name
    ['Gold', 19.30, 'gold'],
    ['Platinum', 21.45, 'color: #e5e4e2' ], // CSS-style declaration
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


    $scope.vendorChart1 = vendorChart1;
    $scope.vendorChart2 = vendorChart2;
    $scope.vendorChart3 = vendorChart3;

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



