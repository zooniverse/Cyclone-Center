$ = require 'jqueryify'
Subject = require 'zooniverse/lib/models/subject'
config = require '../lib/config'
Api = require 'zooniverse/lib/api'

randomPropertyFrom = (object, pattern) ->
  keys = Object.keys object
  keys = (key for key in keys when key.match pattern) if pattern?
  keys[Math.floor Math.random() * keys.length]

class CycloneSubject extends Subject
  @configure 'CycloneSubject', 'zooniverse_id', 'workflowId', 'groupId', 'location', 'coords', 'metadata'

  @current: null

  @next: (callback) =>
    @current.destroy() if @current

    fetcher = if @count() is 0
      @fetch()
    else
      d = new $.Deferred
      d.resolve @all()
      d.promise()

    nexter = fetcher.pipe =>
      @current = @first()
      @current

    nexter.then callback

    nexter

  @fetch: (count = config.setSize) =>
    fetcher = $.Deferred()

    Api.get "/projects/cyclone_center/groups/subjects?limit=#{count}", (rawSubjects) =>
      newSubjects = @fromJSON rawSubject for rawSubject in rawSubjects
      fetcher.resolve newSubjects

    fetcher.promise()

  @fromJSON: (raw) =>
    satellite = randomPropertyFrom raw.location, /[^-yesterday]$/

    @create
      id: raw.id
      zooniverseId: raw.zooniverse_id
      workflowId: raw.workflow_ids[0]
      groupId: raw.group_id
      location:
        standard: raw.location[satellite]
        yesterday: raw.location["#{satellite}-yesterday"]
      coords: [
        raw.metadata.lat || raw.metadata.map_lat
        raw.metadata.lng || raw.metadata.map_lng
      ]
      metadata: raw.metadata

  talkHref: ->
    "http://talk.cyclonecenter.org/objects/#{@zooniverseId}"

module.exports = CycloneSubject
module.exports.randomPropertyFrom = randomPropertyFrom # For convenience
