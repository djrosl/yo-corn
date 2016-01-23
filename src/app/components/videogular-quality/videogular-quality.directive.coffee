do ->
  'use strict'
  angular.module('th.co.softever.videogular.plugins.quality', []).run([
    '$templateCache'
    ($templateCache) ->
      $templateCache.put 'vg-templates/vg-quality', '<div>{{ currentQuality.name }}
      <span class="vg-auto-quality">{{ (autoQualityName && "("+ autoQualityName +")" || null) }}</span></div>
        <vg-quality-selector></<vg-quality-selector>'
      return
  ]).directive 'vgQuality', [
    'VG_UTILS'
    (VG_UTILS) ->
      {
        restrict: 'E'
        require: '^videogular'
        templateUrl: 'vg-templates/vg-quality'
        scope:
          qualities: '=qualitySources'
          currentQuality: '=defaultQuality'
        link: (scope, elem, attr, API) ->

          scope.onMouseOverQuality = ->
            scope.$evalAsync ->
              scope.qualityVisibility = 'visible'
              return
            return

          scope.onMouseLeaveQuality = ->
            scope.$evalAsync ->
              scope.qualityVisibility = 'hidden'
              return
            return

          # We hide quality selector controls on mobile devices
          if VG_UTILS.isMobileDevice()
            elem.css 'display', 'none'
          else
            scope.qualityVisibility = 'hidden'
            elem.bind 'mouseover', scope.onMouseOverQuality
            elem.bind 'mouseleave', scope.onMouseLeaveQuality
          return

      }
  ]
  return
do ->
  angular.module('th.co.softever.videogular.plugins.quality').run([
    '$templateCache'
    ($templateCache) ->
      $templateCache.put 'vg-templates/vg-quality-selector',
      '<ul><li ng-repeat="o in qualities" ng-class="{\'active\':currentQuality === o}" ng-click="changeQuality(o)">
        {{ o.name }}</li></ul>'
      return
  ]).directive 'vgQualitySelector', [
    'VG_STATES'
    (VG_STATES) ->
      {
        restrict: 'E'
        require: '^videogular'
        templateUrl: 'vg-templates/vg-quality-selector'
        link: (scope, elem, attr, API) ->
          scope.currentTime = 0
          scope.playback = API.playback

          scope.getQualityNameByDashIndex = (index) ->
            i = 0
            while i < scope.qualities.length
              if scope.qualities[i].dashIndex == index
                return scope.qualities[i].name
              i++
            return

          setQualityUpdateIntervel = ->
            qualityUpdateInterval = setInterval((->
              scope.autoQualityName = scope.getQualityNameByDashIndex(API.dashPlayer.getQualityFor('video'))
              return
            ), 3000)
            return

          scope.isDASHSupport = ->
            ! !window.MediaSource

          qualityUpdateInterval = undefined
          # Fallback to normal Videogular if browser not support MPEGDASH
          if scope.isDASHSupport()
            if API.isDASH and API.isDASH(scope.currentQuality.sources[0].src)
              setQualityUpdateIntervel()
          else
            if API.isDASH and API.isDASH(scope.currentQuality.sources[0].src)
              i = 0
              while i < scope.qualities.length
                if scope.qualities[i] == scope.currentQuality
                  scope.qualities.splice i, 1
                  scope.currentQuality = scope.qualities[0]
                i++
          if API.isDASH and API.isDASH(scope.currentQuality.sources[0].src)

            scope.dashLoaded = ->
              API.dashPlayer.seek scope.currentTime / 1000
              if scope.currentState == VG_STATES.PLAY
                API.dashPlayer.play()
              API.dashPlayer.getVideoModel().getElement().removeEventListener 'loadedmetadata', scope.dashLoaded.bind(scope)
              API.setPlayback scope.playback
              return

            scope.changeQuality = (quality) ->
              API.dashPlayer.getVideoModel().getElement().addEventListener 'loadedmetadata', scope.dashLoaded.bind(scope)
              scope.currentQuality = quality
              scope.currentTime = API.currentTime
              scope.playback = API.playback
              scope.qualityVisibility = 'hidden'
              scope.currentState = API.currentState
              if !API.isDASH(quality.sources[0].src)
                API.dashPlayer.setAutoSwitchQuality false
                API.dashPlayer.setQualityFor 'video', quality.dashIndex
                clearInterval qualityUpdateInterval
                scope.autoQualityName = null
              else
                API.dashPlayer.setAutoSwitchQuality true
                setQualityUpdateIntervel()
              return

          else

            scope.changeQuality = (quality) ->
              scope.currentQuality = quality
              scope.qualityVisibility = 'hidden'
              scope.currentTime = API.currentTime
              scope.currentState = API.currentState
              scope.playback = API.playback
              API.changeSource quality.sources
              return

            scope.onMediaLoaded = ->
              API.seekTime scope.currentTime / 1000
              API.setPlayback scope.playback
              if scope.currentState == VG_STATES.PLAY
                API.play()
              return

            API.mediaElement[0].addEventListener 'loadedmetadata', scope.onMediaLoaded.bind(scope), false

          scope.onChangeVisibility = (value) ->
            elem.css 'visibility', value
            return

          scope.$watch 'qualityVisibility', scope.onChangeVisibility
          return

      }
  ]
  return

# ---
# generated by js2coffee 2.1.0