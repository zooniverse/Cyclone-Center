$ = require 'jqueryify'
Subject = require 'zooniverse/lib/models/subject'
config = require '../lib/config'

class CycloneSubject extends Subject
  @configure 'CycloneSubject', 'zooniverse_id', 'coords', 'location', 'metadata'

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

    resolveFetcher = =>
      fetcher.resolve (@createFake() for i in [0...count])

    setTimeout resolveFetcher, 2000

    fetcher.promise()

  @createFake = ->
    @create
      id: Math.floor Math.random() * 1000
      location: standard: 'http://placehold.it/1/000.png'
      coords: [
        +(Math.random() * 5 + 20).toString().slice 0, 7
        +(Math.random() * -10 - 60).toString().slice 0, 7
      ]
      metadata: {}

module.exports = CycloneSubject
