# Service for work with API
angular.module 'yoCorn'
  .factory 'api', ['$log', '$http', '$resource', ($log, $http, $resource) ->
    'ngInject'
    apiHost = 'http://hubler.ru/api/v1'

    service =
      host: apiHost
      config: $resource apiHost+'/configurations/:config_name',
        config_name: '@config_name'
      videos: $resource apiHost+'/videos?lang=:lang&skip=:skip&take=:take&durfrom=:durfrom&durto=:durto&sort=:sort',
        lang: "@lang"
        skip: "@skip"
        take: "@take"
        durfrom: "@durfrom"
        durto: "@durto"
        sort: "@sort"
        ,query:
          method: 'GET'
          isArray: true
      video: $resource apiHost+'/videos/:video_id?lang=:lang',
        lang: "@lang"
        video_id: "@video_id"
      categories: $resource apiHost+'/categories?lang=:lang',
        lang: "@lang"
        ,query:
          method: 'GET'
          isArray: true
      promos: $resource apiHost+'/promos?lang=:lang',
        lang: "@lang"
        ,query:
          method: 'GET'
          isArray: true
      users: $resource apiHost+'/users/:id',
        id: '@id'
      related: $resource apiHost+'/videos/:id/recommendations?lang=:lang&skip=:skip&take=:take',
        lang: "@lang"
        skip: "@skip"
        take: "@take"
        id: "@id"
        ,query:
          method: 'GET'
          isArray: true
      comments: $resource apiHost+'/videos/:id/comments?skip=:skip&take=:take',
        skip: "@skip"
        take: "@take"
        id: "@id"
        ,query:
          method: 'GET'
          isArray: true
      actors: $resource apiHost+'/persons?lang=:lang&skip=:skip&take=:take',
        lang: "@lang"
        skip: "@skip"
        take: "@take"
        ,query:
          method: 'GET'
          isArray: true
      actor: $resource apiHost+'/persons/:actor?lang=:lang',
        lang: "@lang"
        actor: "@actor"
  ]