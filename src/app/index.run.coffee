angular.module 'yoCorn'
  .run ($log, $rootScope, $window) ->
    'ngInject'
    $log.debug 'runBlock end'
    $rootScope.$on '$stateChangeSuccess', ->
      $rootScope.config.show_slider = 0
      $rootScope.config.show_controls = 0
      $("html, body").animate
        scrollTop: 0
        ,500
