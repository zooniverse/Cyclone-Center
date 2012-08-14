$ = require 'jqueryify'
Subject = require 'zooniverse/lib/models/subject'
config = require '../lib/config'

previewImages = [
  'preview-subjects/1984314N09088.MISSING.1984.11.09.0300.61.GMS-3.020.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.09.0600.61.GMS-3.021.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.09.1200.62.GMS-3.024.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.10.0000.63.GMS-3.028.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.10.0900.64.GMS-3.028.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.10.1200.65.GMS-3.028.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.11.0000.66.GMS-3.038.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.11.0600.67.GMS-3.042.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.11.1200.68.GMS-3.056.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.12.0000.68.GMS-3.071.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.12.1200.69.GMS-3.075.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.12.1500.69.GMS-3.076.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.13.1500.69.GMS-3.080.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.13.2100.69.GMS-3.078.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.14.0000.69.GMS-3.075.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.14.0300.69.GMS-3.074.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.14.1500.69.GMS-3.064.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.14.2100.69.GMS-3.052.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.15.0000.69.GMS-3.042.hursat-b1.v05.png'
  'preview-subjects/1984314N09088.MISSING.1984.11.15.0600.70.GMS-3.031.hursat-b1.v05.png'
]

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
      location: standard: previewImages[Math.floor Math.random() * previewImages.length]
      coords: [
        +(Math.random() * 5 + 20).toString().slice 0, 7
        +(Math.random() * -10 - 60).toString().slice 0, 7
      ]
      metadata: {
        captured: new Date Math.random() * new Date
      }

module.exports = CycloneSubject
