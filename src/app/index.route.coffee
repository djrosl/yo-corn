angular.module 'yoCorn'
  .config ($stateProvider, $urlRouterProvider, $locationProvider) ->
    'ngInject'
    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: 'app/main/main.html'
        controller: 'MainController'
        controllerAs: 'main'
      .state 'video',
        url: '/video/:id'
        templateUrl: 'app/video/video.html'
        controller: 'VideoController'
        controllerAs: 'video'
      .state 'actors',
        url: '/actors'
        templateUrl: 'app/actors/actors.html'
        controller: 'ActorsController'
        controllerAs: 'actors'
      .state 'categories',
        url: '/categories'
        templateUrl: 'app/categories/categories.html'
        controller: 'CategoriesController'
        controllerAs: 'categories'
      .state '404',
        url: '/404'
        templateUrl: 'app/error/404.html'
        controller: 'ErrorController'
        controllerAs: 'error'

    $urlRouterProvider.otherwise '/404'
    $locationProvider.html5Mode(false)
