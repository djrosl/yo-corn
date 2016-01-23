angular.module 'yoCorn'
  .directive 'fancyselect', ->
    directive =
      restrict: 'A'
      link: (scope, el, attrs)->
        $(el).fancySelect().on 'change.fs', ->
          if attrs.sortName is 'duration' then scope.$root.duration = this.value else scope.$root.params = this.value
          scope.$root.$apply()