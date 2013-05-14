Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/home'
StormStatus = require './storm-status'

storms = require '../lib/storms'

class Home extends Controller
  className: 'home'
  template: template

  elements:
    '.active-storms': 'activeStormsContainer'

  constructor: ->
    super

    statuses = [
      new StormStatus group: storms[0]
      new StormStatus group: storms[1]
      new StormStatus group: storms[2]
    ]

    status.el.appendTo @activeStormsContainer for status in statuses

module.exports = Home
