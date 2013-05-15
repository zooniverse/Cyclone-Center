BaseController = require 'zooniverse/controllers/base-controller'
template = require '../views/storm-status'
Api = require 'zooniverse/lib/api'
Subject = require 'zooniverse/models/subject'

class StormStatus extends BaseController
  group: ''
  storm: null

  className: 'storm-status'
  template: template

  events:
    'click button[name="select"]': 'onSelect'

  elements:
    '.preview': 'previewImg'
    '.progress .fill': 'fill'
    '.complete .value': 'completeValue'
    '.name': 'nameContainer'
    '.year': 'yearContainer'

  constructor: ->
    super

    @constructor.on 'select', @onGroupChanged

    Api.current.get "/projects/#{Api.current.project}/groups/#{@group}", (storm) =>
      @storm = storm
      @render()

  render: ->
    middleCapture = @storm.metadata.stats[Math.floor @storm.metadata.stats.length / 2]

    {lat, lng} = middleCapture
    previewSrc = @storm.preview || "http://maps.googleapis.com/maps/api/staticmap?center=#{lat},#{lng}&zoom=3&size=320x160&sensor=false"
    @previewImg.attr src: previewSrc

    finished = @storm.stats.complete / @storm.stats.total
    @fill.css width: "#{finished * 100}%"
    @completeValue.html Math.floor finished * 100

    @nameContainer.html @storm.name
    @yearContainer.html parseInt middleCapture.time, 10

  # NOTE: This is also called manually from the home controller.
  onSelect: ->
    Subject.group = @group
    Subject.destroyAll()

    StormStatus.trigger 'select', @group

    @el.addClass 'loading'
    Subject.next =>
      @el.removeClass 'loading'
      location.hash = '/classify'

  onGroupChanged: (e, group) =>
    @el.toggleClass 'active', group is @group

module.exports = StormStatus
