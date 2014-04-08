angular.module("google-chart-sample", ["ngRoute", "googlechart"]).config(['$routeProvider',
    function ($routeProvider) {
        $routeProvider.
            when('/fat', {
                templateUrl: 'fat.html',
                controller: 'FatChartCtrl'
            }).
            when('/annotation', {
                templateUrl: 'annotation.html',
                controller: 'AnnotationChartCtrl'
            }).
            when('/generic/:chartType', {
                templateUrl: 'generic.html',
                controller: 'GenericChartCtrl'
            }).
            otherwise({
                redirectTo: '/fat'
            });
    }])
