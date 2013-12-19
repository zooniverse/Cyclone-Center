Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/home'
PreferenceCheckbox = require './preference-checkbox'
translate = require 't7e'
StormStatus = require './storm-status'
Footer = require 'zooniverse/controllers/footer'
Subject = require 'zooniverse/models/subject'
featuredStorms = require '../../public/js/featured-storms'

class Home extends Controller
  className: 'home'
  template: template

  events:
    'click button[name="random"]': 'onClickRandom'

  elements:
    '.notification-preference': 'notificationPreferenceContainer'
    '.active-storms': 'featuredStormsContainer'
    'button[name="random"]': 'randomButton'

  constructor: ->
    super

    contactCheckbox = new PreferenceCheckbox
      setting: 'contact'
      label: translate 'span', 'home.stormChangeContact'

    @notificationPreferenceContainer.append contactCheckbox.el

    for storm in featuredStorms
      (new StormStatus group: storm).el.appendTo @featuredStormsContainer

    StormStatus.on 'select', =>
      StormStatus::onGroupChanged.apply el: @randomButton, group: true, arguments

    footer = new Footer
    footer.el.appendTo @el

  onClickRandom: ->
    # Pretend we selected a group from the home page:
    StormStatus::select.call(el: @randomButton, group: true).then ->
      location.hash = '/classify'

module.exports = Home
