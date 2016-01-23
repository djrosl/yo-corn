angular.module 'yoCorn'
  .directive 'mobilyslider', ->
    directive =
      restrict: 'A'
      link: (scope, el, attrs)->
        $(el).mobilyslider
          transition: 'fade'
          animationSpeed: 800
          bullets: true
          arrowsHide: false
          arrows:true