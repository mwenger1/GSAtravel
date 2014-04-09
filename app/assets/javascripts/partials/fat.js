'use strict';

angular.module('google-chart-sample').controller("FatChartCtrl",["$scope", function ($scope) {

    $scope.report_type = "vendor";
    $scope.chart_number = 1;

  $scope.count = 0;
    $scope.updateChartNumber = function(number){
        $scope.chart_number = number;
      };

    $scope.updateChartOnly = function(type){
        $scope.report_type = type;
      };

}]);



