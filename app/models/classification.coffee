$ = require 'jqueryify'
Api = require 'zooniverse/lib/api'

splitObject = (object) ->
  for key, value of object
    newObject = {}
    newObject[key] = value
    newObject

class Classification
  subject: null

  annotations: null
  emitter: null

  constructor: ({@subject}) ->
    @annotations = {}
    @emitter = $({})

    @annotate 'satellite', @subject.metadata.satellite

  annotate: (key, value) ->
    @annotations[key] = value
    @emitter.trigger "change", [key, value]

  get: (key) =>
    @annotations[key]

  onChange: (callback) ->
    @emitter.on 'change', (e, key, value) ->
      callback key, value

  toJSON: ->
    classification:
      subject_ids: [@subject.id]
      annotations: splitObject @annotations

  url: ->
    "/projects/cyclone_center/workflows/#{@subject.workflowId}/classifications"

  send: ->
    alert 'Not actually sending classification. This is an old version of the site.'
    (new $.Deferred).then(arguments...).resolve true

module.exports = Classification
