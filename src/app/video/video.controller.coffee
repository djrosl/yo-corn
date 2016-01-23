angular.module 'yoCorn'
  .controller 'VideoController', ['$stateParams', '$filter', '$sce', '$rootScope', 'api', ($stateParams, $filter, $sce, $rootScope, api) ->
        'ngInject'
        vm = this

        $rootScope.config.show_slider = 0
        $rootScope.config.show_controls = 0
        videoId = $stateParams.id

        vm.videoData = api.video.get
          video_id: videoId
          lang: $rootScope.language
        , (data)->

          vm.config =
            theme: url: 'http://www.videogular.com/styles/themes/default/latest/videogular.css'
            preload: 'none'
            qualitySources: []
            plugins: controls:
              autoHide: true
              autoHideTime: 5000
            poster: "http://hubler.ru/api/v1/pictures/"+data.PictureId+"/data/111"

          angular.forEach data.Formats, (v,k)->
            source =
              name: v.ResolutionY
              sources: [ {
                src: $sce.trustAsResourceUrl('http://hubler.ru/api/v1/videos/'+videoId+'/data/'+v.VdType)
                type: 'video/mp4'
              } ]
              dashIndex: 10-k
            vm.config.qualitySources.push source
            vm.currentQualitySource = source if !k

          vm.owner = api.users.get
            id: data.CreatedBy
        vm.related = api.related.query
          lang: $rootScope.language
          skip: 0
          take: 4
          id: videoId
        vm.comments = api.comments.query
          skip: 0
          take: 4
          id: videoId

        $rootScope.slideout = true

        #show/hide describe
        $('.show_describe').click ->
          $(this).parents('.describe').find('.describe_hidden').slideToggle(400)
          $(this).parents('.describe').find('.show_describe').toggleClass('is_showed')
        

        return
  ]