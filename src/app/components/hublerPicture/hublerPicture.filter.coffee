angular.module 'yoCorn'
  .filter 'hublerPicture', ->
    (id, format)->
      "http://hubler.ru/api/v1/pictures/"+id+"/data/"+format