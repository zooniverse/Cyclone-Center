$ = require 'jqueryify'
Subject = require 'zooniverse/lib/models/subject'
config = require '../lib/config'
Api = require 'zooniverse/lib/api'

randomPropertyFrom = (object, pattern) ->
  keys = Object.keys object
  keys = (key for key in keys when key.match pattern) if pattern?
  keys[Math.floor Math.random() * keys.length]

class CycloneSubject extends Subject
  @configure 'CycloneSubject', 'zooniverseId', 'workflowId', 'groupId', 'location', 'coords', 'metadata', 'firstOfSet'

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

  @fetch: (count = config.setSize, fetcher) =>
    fetcher ?= $.Deferred()

    Api.get "/projects/cyclone_center/groups/subjects?limit=#{count}", (rawSubjects) =>
      console.info "Got #{rawSubjects.length} new subjects!", rawSubjects
      newSubjects = (@fromJSON rawSubject for rawSubject in rawSubjects)
      newSubjects[0].firstOfSet = true
      newSubjects[0].save()
      fetcher.resolve newSubjects

    fetcher.promise()

  @fromJSON: (raw) =>
    satellite = randomPropertyFrom raw.location, /[^-yesterday]$/

    subject = @create
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

    subject.metadata.satellite = satellite

    for location, src of subject.location
      continue unless src
      preload = $("<img src='#{src}' />")
      preload.appendTo 'body'
      preload.on 'load', -> $(@).remove()

    subject

  talkHref: ->
    "http://talk.cyclonecenter.org/objects/#{@zooniverseId}"

module.exports = CycloneSubject
module.exports.randomPropertyFrom = randomPropertyFrom # For convenience
