angular.module 'yoCorn'
  .controller 'CategoriesController', ['$rootScope', 'api', ($rootScope, api) ->
    'ngInject'
    vm = this

    vm.models = $rootScope.categories


  ]