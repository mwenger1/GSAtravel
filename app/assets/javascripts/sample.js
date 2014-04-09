angular.module("google-chart-sample", ["ngRoute", "googlechart"]).config(['$routeProvider',
    function ($routeProvider) {
        $routeProvider.
            when('/flights', {
                templateUrl: 'partials/fat.html',
                controller: 'FatChartCtrl'
            }).
            when('/hotels', {
                templateUrl: 'partials/annotation.html',
                controller: 'AnnotationChartCtrl'
            }).
            when('/car_rentals', {
                templateUrl: 'partials/generic.html',
                controller: 'GenericChartCtrl'
            }).
            otherwise({
                redirectTo: '/flights'
            });
    }])
