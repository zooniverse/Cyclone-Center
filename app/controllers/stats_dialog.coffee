Dialog = require 'zooniverse/lib/dialog'
Api = require 'zooniverse/lib/api'
Map  = require 'zooniverse/lib/map'
BarGraph  = require 'zooniverse/lib/bar_graph'

template = require 'views/stats_dialog'

class StatsDialog extends Dialog
  stormId: ''
  storm: null

  content: 'Loading...'
  openImmediately: true

  constructor: ->
    super

    @buttons = []

    @storm =
      name: ''
      strength: ''
      coords: []
      times: []
      pressures: []
      winds: []

    dialog = @

    @el.on 'mouseenter', '.bar-chart .item', ->
      index = $(@).index()
      dialog.el.find('.bar-chart').each ->
        $(@).children().eq(index).addClass 'hover'
        dialog.map.labels[index - 1].setRadius 10

    @el.on 'mouseleave', '.bar-chart .item', ->
      index = $(@).index()
      dialog.el.find('.bar-chart').each ->
        $(@).children().eq(index).removeClass 'hover'
        dialog.map.labels[index - 1].setRadius 5

    console.log "/projects/cyclone_center/groups/#{@stormId}"

    Api.get "/projects/cyclone_center/groups/#{@stormId}", (raw) =>
      console.log raw
      @storm.name = raw.metadata.name
      @storm.strength = raw.metadata.max_category
      for stat in raw.metadata.stats
        @storm.coords.push [stat.lat, stat.lng]
        @storm.times.push stat.time
        @storm.winds.push stat.wind.wmo || stat.wind.max
        @storm.pressures.push stat.pressure.wmo || stat.pressure.max

      @content = template @storm
      @render()
      @addData()

      @attach() # I have no idea why I have to call this twice.
      @attach() # I have no idea why I have to call this twice.

    @el.addClass 'stats'

  addData: =>
    @map = new Map
      el: @el.find '.path .map'
      zoom: 2

    allLats = []
    allLngs = []

    @storm.coords.forEach (coords) =>
      coords[1] += 360 if coords[1] < 0 # 0 through 360 instead of -180 through +180

      @map.addLabel coords..., ''
      allLats.push coords[0]
      allLngs.push coords[1]

    avgCoords = [
      (1 / allLats.length) * allLats.reduce (a, b) -> a + b
      (1 / allLngs.length) * allLngs.reduce (a, b) -> a + b
    ]

    @map.resize()
    @map.setZoom @map.zoom
    @map.setCenter avgCoords...

    @windSpeedGraph = new BarGraph
      el: @el.find '.wind-speed .graph'
      x: 'Date': @storm.times
      y: 'kt': @storm.winds

    @pressureGraph = new BarGraph
      el: @el.find '.pressure .graph'
      x: 'Date': @storm.times
      y: 'mb': @storm.pressures
      floor: Math.floor 0.95 * Math.min @storm.pressures...

window.SD = StatsDialog
module.exports = StatsDialog
