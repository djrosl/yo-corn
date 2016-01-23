angular.module 'yoCorn'
  .controller 'ActorsController', ['$rootScope', 'api', ($rootScope, api) ->
    'ngInject'
    vm = this

    vm.actors = []
    $rootScope.loading = true
    api.actors.query
      lang: $rootScope.language
      skip: 0
      take: 100
    .$promise.then (data)->
        vm.actors = data
        $rootScope.loading = false
    return
  ]