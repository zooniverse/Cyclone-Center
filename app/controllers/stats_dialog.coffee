Dialog = require 'zooniverse/lib/dialog'
Api = require 'zooniverse/lib/api'
Map  = require 'zooniverse/lib/map'
BarGraph  = require 'zooniverse/lib/bar_graph'

template = require 'views/stats_dialog'

class StatsDialog extends Dialog
  stormId: ''
  storm: null

  constructor: ->
    super
    @buttons = []
    @el.addClass 'stats'

    @storm =
      name: ''
      strength: ''
      coords: []
      times: []
      pressures: []
      winds: []

    Api.get "/projects/cyclone_center/groups/#{@stormId}", (raw) =>
      @storm.name = raw.metadata.name
      @storm.strength = raw.metadata.max_category
      for stat in raw.metadata.stats
        @storm.coords.push [stat.lat, stat.lng]
        @storm.times.push stat.time
        @storm.winds.push stat.wind.wmo || stat.wind.min
        @storm.pressures.push stat.wind.wmo || stat.pressure.min

      @content = template @storm
      @open()

  render: =>
    super

    @map = new Map
      el: @el.find '.path .map'
      zoom: 2

    allLats = []
    allLngs = []

    @storm.coords.forEach (coords) =>
      @map.addLabel coords..., ''
      allLats.push coords[0]
      allLngs.push coords[1]

    avgCoords = [
      (1 / allLats.length) * allLats.reduce (a, b) -> a + b
      (1 / allLngs.length) * allLngs.reduce (a, b) -> a + b
    ]

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

  open: =>
    super
    @map.resize()
    @map.setZoom @map.zoom

module.exports = StatsDialog
