jQuery.event.special.delayedkeypress =
  delegateType: 'keyup'
  bindType: 'keyup'
  handle: (event) ->
    self = this
    @timer and clearTimeout(@timer)
    @timer = setTimeout((->
      event.handleObj.handler.apply self, arguments
    ), 500)

jQuery.fn['delayedkeypress'] = (data, fn) ->
  if arguments.length > 0 then @on('delayedkeypress', null, data, fn) else @trigger('delayedkeypress')
