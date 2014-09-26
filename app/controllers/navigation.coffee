BaseController = require 'zooniverse/controllers/base-controller'

class Navigation extends BaseController
  className: 'site-navigation'
  template: require '../views/navigation'

  constructor: ->
    super

module.exports = Navigation
