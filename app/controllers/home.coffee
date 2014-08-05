Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/home'
PreferenceCheckbox = require './preference-checkbox'
translate = require 't7e'
StormStatus = require './storm-status'
Footer = require 'zooniverse/controllers/footer'
featuredStorms = require '../../public/js/featured-storms'

formatNumber = (n) ->
  return n unless n
  n.toString().replace /(\d)(?=(\d{3})+(?!\d))/g, '$1,'

class Home extends Controller
  className: 'home'
  template: template
  group: true

  events:
    'click button[name="random"]': 'onClickRandom'

  elements:
    '.notification-preference': 'notificationPreferenceContainer'
    '.active-storms': 'featuredStormsContainer'
    'button[name="random"]': 'randomButton'
    '.progress-bar': 'progressBar'
    '.needed_classifications': 'neededClassifications'
    '.provided_classifications': 'providedClassifications'

  constructor: ->
    super

    contactCheckbox = new PreferenceCheckbox
      setting: 'contact'
      label: translate 'span', 'home.stormChangeContact'

    @notificationPreferenceContainer.append contactCheckbox.el

    for storm in featuredStorms.sort(-> Math.random() - Math.random())
      (new StormStatus storm).el.appendTo @featuredStormsContainer

    StormStatus.on 'select', =>
      StormStatus::onGroupChanged.apply el: @randomButton, group: true, arguments

    footer = new Footer
    footer.el.appendTo @el

    @updateCampaignProgress()

    interval = 1000 * 60 * 5
    setInterval @updateCampaignProgress, interval

  onClickRandom: ->
    # Pretend we selected a group from the home page:
    StormStatus::select.call(el: @randomButton, group: @group).then ->
      location.hash = '/classify'

  updateCampaignProgress: ->
    $.getJSON 'http://zooniverse-demo.s3.amazonaws.com/2005-storm-status.json', ({ needed_classifications, provided_classifications, storms }) =>
      @group = storms[Math.floor Math.random() * storms.length]
      @randomButton.attr 'disabled', false

      percentComplete = Math.floor((provided_classifications / needed_classifications).toFixed(2) * 100)

      @providedClassifications.html formatNumber provided_classifications
      @neededClassifications.html formatNumber needed_classifications

      @progressBar.animate {
        width: "#{ percentComplete }%"
      }, {
        duration: 500
      }

module.exports = Home
