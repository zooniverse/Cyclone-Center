Controller = require 'zooniverse/controllers/base-controller'

class Home extends Controller
  className: 'home'
  template: require '../views/home'

  constructor: ->
    super

module.exports = Home
