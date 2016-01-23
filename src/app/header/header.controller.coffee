angular.module 'yoCorn'
  .controller 'HeaderController', ['$timeout', '$rootScope', '$cookies', 'api', ($timeout, $rootScope, $cookies, api) ->
        'ngInject'
        vm = this

        #init config
        $rootScope.config = {}

        $rootScope.params = 'view'
        $rootScope.duration = '0,600'
        
        #check language from cookies
        $rootScope.language = if $cookies.get 'lang' then $cookies.get 'lang' else 0
        $cookies.put 'lang', $rootScope.language

        #remove startup popup if clicked
        $rootScope.prompt = if $cookies.get 'prompt' then 0 else 1
        $rootScope.removePrompt = ->
          $cookies.put 'prompt', 0
          $rootScope.prompt = 0

        #change language from dropdown list
        vm.changeLanguage = (id)->
          $rootScope.language = id
          $cookies.put 'lang', id
          window.location.reload()
        
        #list of languages
        vm.languages = [
          {id:0
          name:'Русский'
          picture: '/assets/img/ru.png'},
          {id:1
          name:'English'
          picture: '/assets/img/en.png'},
          {id:2
          name:'Spanish'
          picture: '/assets/img/sp.jpg'},
          {id:3
          name:'German'
          picture: '/assets/img/gm.jpg'},
          {id:4
          name:'French'
          picture: '/assets/img/fr.png'},
          {id:5
          name:'Chinese'
          picture: '/assets/img/ch.png'},
          {id:6
          name:'Japanese'
          picture: '/assets/img/jp.png'}
        ]

        $rootScope.categories = api.categories.query
          lang: $rootScope.language

        vm.promos = []

        api.promos.query
          lang: $rootScope.language
        .$promise.then (data)->
          angular.forEach data, (v,k)->
            if v.PictureId
              slide = {}
              slide.picture = "http://hubler.ru/api/v1/pictures/"+v.PictureId+"/data/140"
              slide.text = v.Text
              vm.promos.push slide


        $('body').on 'click', '.top_banner_button', ->
          $('#slideout').find('.top_banner_button2').css("opacity","1", "z-index","99")
          $('#slideout').find('#slideout_inner').css("right","0")
          $('#slideout').find('.top_banner_button').css("opacity","0", "z-index","-1")

        $('body').on 'click', '.top_banner_button2', ->
          $('#slideout').find('#slideout_inner').css("right","-250px")
          $('#slideout').find('.top_banner_button').css("opacity","1", "z-index","99")
          $('#slideout').find('.top_banner_button2').css("opacity","0", "z-index","-1")

        return
    ]