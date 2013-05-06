template = require '../views/navigation'

class Navigation
  el: null

  constructor: ->
    @el = $($.trim template @)

module.exports = Navigation
