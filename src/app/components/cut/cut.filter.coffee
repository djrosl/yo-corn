angular.module 'yoCorn'
  .filter 'cut', ->
    (value, wordwise, max, tail) ->
      if !value
        return ''
      value = value.replace /(<([^>]+)>)|\&nbsp;/ig,""
      max = parseInt(max, 10)
      if !max
        return value
      if value.length <= max
        return value
      value = value.substr(0, max)
      value + (tail or ' …')