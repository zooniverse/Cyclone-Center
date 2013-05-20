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

    statuses = [
      new StormStatus group: activeStorms[0]
      new StormStatus group: activeStorms[1]
      new StormStatus group: activeStorms[2]
    ]

    status.el.appendTo @activeStormsContainer for status in statuses

    StormStatus.on 'select', =>
      StormStatus::onGroupChanged.apply el: @randomButton, group: true, arguments

    footer = new Footer
    footer.el.appendTo @el

  onClickRandom: ->
    # Pretend we selected a group from the home page:
    StormStatus::onSelect.call el: @randomButton, group: true

module.exports = Home
