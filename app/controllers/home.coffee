Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/home'
StormStatus = require './storm-status'
Footer = require 'zooniverse/controllers/footer'
Subject = require 'zooniverse/models/subject'
{active: activeStorms, completed: completedStorms} = require '../lib/storms'

class Home extends Controller
  className: 'home'
  template: template

  events:
    'click button[name="random"]': 'onClickRandom'

  elements:
    '.active-storms': 'activeStormsContainer'
    'button[name="random"]': 'randomButton'

  constructor: ->
    super

    for storm in activeStorms
      (new StormStatus group: storm).el.appendTo @activeStormsContainer

    StormStatus.on 'select', =>
      StormStatus::onGroupChanged.apply el: @randomButton, group: true, arguments

    footer = new Footer
    footer.el.appendTo @el

  onClickRandom: ->
    # Pretend we selected a group from the home page:
    StormStatus::select.call el: @randomButton, group: true

module.exports = Home
