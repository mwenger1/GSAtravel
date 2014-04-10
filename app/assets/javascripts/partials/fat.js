'use strict';

angular.module('google-chart-sample').controller("FatChartCtrl",["$scope", function ($scope) {
    $scope.report_type = "vendor";
    $scope.chart_number = 1;

    var chart1 = {};
    chart1.type = "PieChart";
    chart1.displayed = false;
    chart1.data = {"cols": [
        {id: "month", label: "Month", type: "string"},
        {id: "laptop-id", label: "Laptop", type: "number"},
        {id: "desktop-id", label: "Desktop", type: "number"},
        {id: "server-id", label: "Server", type: "number"},
        {id: "cost-id", label: "Shipping", type: "number"}
    ], "rows": [
        {c: [
            {v: "January"},
            {v: 19, f: "42 items"},
            {v: 12, f: "Ony 12 items"},
            {v: 7, f: "7 servers"},
            {v: 4}
        ]},
        {c: [
            {v: "February"},
            {v: 13},
            {v: 1, f: "1 unit (Out of stock this month)"},
            {v: 12},
            {v: 2}
        ]},
        {c: [
            {v: "March"},
            {v: 24},
            {v: 5},
            {v: 11},
            {v: 6}

        ]}
    ]};

    chart1.options = {
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




    chart1.formatters = {};

    $scope.chart = chart1;
    $scope.cssStyle = "height:600px; width:100%;";

    $scope.reportTypeChange = function (report) {
        $scope.report_type = report;
    }



    $scope.chartSelectionChange = function (chart) {
        // $scope.chart = chart;

        if (($scope.chart.type === 'Table' && $scope.chart.data.cols.length === 6 && $scope.chart.options.tooltip.isHtml === true) ||
            ($scope.chart.type != 'Table' && $scope.chart.data.cols.length === 6 && $scope.chart.options.tooltip.isHtml === false)) {
            $scope.chart.data.cols.pop();
            delete $scope.chart.data.rows[0].c[5];
            delete $scope.chart.data.rows[1].c[5];
            delete $scope.chart.data.rows[2].c[5];
        }


        if ($scope.chart.type === 'Table') {

            $scope.chart.options.tooltip.isHtml = false;

            $scope.chart.data.cols.push({id: "data-id", label: "Date", type: "date"});
            $scope.chart.data.rows[0].c[5] = {v: "Date(2013,01,05)"};
            $scope.chart.data.rows[1].c[5] = {v: "Date(2013,02,05)"};
            $scope.chart.data.rows[2].c[5] = {v: "Date(2013,03,05)"};
        }

    }


    $scope.chartReady = function () {
        fixGoogleChartsBarsBootstrap();
    }

    function fixGoogleChartsBarsBootstrap() {
        // Google charts uses <img height="12px">, which is incompatible with Twitter
        // * bootstrap in responsive mode, which inserts a css rule for: img { height: auto; }.
        // *
        // * The fix is to use inline style width attributes, ie <img style="height: 12px;">.
        // * BUT we can't change the way Google Charts renders its bars. Nor can we change
        // * the Twitter bootstrap CSS and remain future proof.
        // *
        // * Instead, this function can be called after a Google charts render to "fix" the
        // * issue by setting the style attributes dynamically.

        $(".google-visualization-table-table img[width]").each(function (index, img) {
            $(img).css("width", $(img).attr("width")).css("height", $(img).attr("height"));
        });
    };

}]);



