angular.module 'yoCorn'
  .config ($httpProvider, $logProvider) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true
