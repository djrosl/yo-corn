angular.module 'yoCorn'
  .controller 'MainController', ['$timeout', '$rootScope', '$scope', 'api', ($timeout, $scope, $rootScope, api) ->
        'ngInject'
        vm = this
        
        $rootScope.slideout = false
        #videos from all categories, on config init
        vm.videos = []
        getVideos = (skip, add)->
          vm.videos = [] if !add
          skip = if skip? then skip else 0
          grid_photos = if $rootScope.config.grid_photos.Value? then $rootScope.config.grid_photos.Value else 16
          videosToAdd = []
          $rootScope.loading = true
          duration = $rootScope.duration.split ','
          api.videos.query
            lang: $rootScope.language
            skip: skip
            take: grid_photos
            durfrom: duration[0]
            durto: duration[1]
            sort: $rootScope.params
          .$promise.then (data)->
            if !add
              vm.noVideos = false
            if !data.length and add
              vm.noVideos = true
              false
            advert_no = parseInt $rootScope.config.grid_advert_no.Value
            i = advert_no - 1
            while i < data.length
              data.splice i, 1, 'AD'
              i = i + 7

            angular.forEach data, (v,k)->
              video = {}

              if v is 'AD'
                #show advert if position match
                video.isAdvert = true
                video.picture = '/assets/img/video2.jpg'
                video.header = 'AD'
              else
                video.picture = if v.PictureId then "http://hubler.ru/api/v1/pictures/"+v.PictureId+"/data/110" else "/assets/img/no_foto.jpg"
                video.header = if v.Description then v.Description else 'No title'
                video.likes = v.LikesCount
                video.dislikes = v.DislikesCount
                video.duration = v.Duration
                video.views = v.Views
                video.comments = v.CommentsCount
                video.id = v.Id
              vm.videos.push video
            $rootScope.loading = false

        #get all config params
        $rootScope.config.show_slider = api.config.get
          config_name: 'show_slider'
        $rootScope.config.show_controls = 1

        $rootScope.config.grid_advert_no = api.config.get
          config_name: 'grid_advert_no'
        $rootScope.config.grid_photos = api.config.get
          config_name: 'grid_photos'
        , ->
          getVideos()

        vm.infinite = ->
          if typeof $rootScope.loading is 'undefined'
            return false
          if $rootScope.loading or vm.videos.length is 0
            return false
          getVideos(vm.videos.length, true)

        $rootScope.$watch 'duration', (newValue, oldValue)->
          if newValue isnt oldValue
            getVideos()
        $rootScope.$watch 'params', (newValue, oldValue)->
          if newValue isnt oldValue
            getVideos()
        return
    ]