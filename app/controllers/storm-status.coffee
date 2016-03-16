BaseController = require 'zooniverse/controllers/base-controller'
template = require '../views/storm-status'
Api = require 'zooniverse/lib/api'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'
$ = window.jQuery

MAP_WIDTH = 225
MAP_HEIGHT = 160

class StormStatus extends BaseController
  group: ''
  image: ''

  storm: null

  className: 'storm-status'
  template: template

  events:
    'click': 'onClick'

  elements:
    '.preview': 'previewImg'
    '.progress .fill': 'fill'
    '.complete .value': 'completeValue'
    '.name': 'nameContainer'
    '.year': 'yearContainer'

  constructor: (storm) ->
    super
    { @group, @image } = storm

    @constructor.on 'select', @onGroupChanged

    Api.current.get "/projects/#{Api.current.project}/groups/#{@group}", (storm) =>
      @storm = storm
      @render()

  render: ->
    middleCapture = @storm.metadata.stats[Math.floor @storm.metadata.stats.length / 2]

    previewSrc = if @image?
      @image
    else
      {lat, lng} = middleCapture
      @storm.metadata.preview || "https://maps.googleapis.com/maps/api/staticmap?center=#{lat},#{lng}&zoom=3&size=#{MAP_WIDTH}x#{MAP_HEIGHT}&sensor=false"

    @previewImg.attr src: previewSrc

    finished = @storm.metadata.provided_classifications / @storm.metadata.needed_classifications
    @fill.css width: "#{ Math.min(finished, 1) * 100 }%"
    @completeValue.html Math.floor finished * 100

    @el.toggleClass 'finished', finished > 0.98

    @nameContainer.html @storm.name
    @yearContainer.html parseInt middleCapture.time, 10

  onClick: (e) ->
    return if @el.hasClass 'finished'

    target = $(e.target)

    unless target.is('a') or target.parents('a').length isnt 0
      @select().then ->
        location.hash = '/classify'

  # NOTE: This is also called manually from the home controller.
  select: ->
    deferred = new $.Deferred

    if Subject.group is @group
      location.hash = '/classify'
      deferred.resolve()

    else
      Subject.group = @group
      Subject.destroyAll()

      StormStatus.trigger 'select', @group

      @el?.addClass 'loading'

      deferred.always =>
        @el?.removeClass 'loading'

      next = Subject.next()

      next.done =>
        deferred.resolve arguments...
        User.current?.setPreference 'storm', @group

      next.fail =>
        deferred.reject arguments...

    deferred

  onGroupChanged: (e, group) =>
    @el.toggleClass 'active', group is @group

module.exports = StormStatus
