Dialog = require 'zooniverse/lib/dialog'
Map  = require 'zooniverse/lib/map'
BarGraph  = require 'zooniverse/lib/bar_graph'

template = require 'views/stats_dialog'

class StatsDialog extends Dialog
  storm: null

  constructor: ->
    super

    @storm ?=
      type: 'Hurricane'
      name: 'Brian'
      start: (new Date).getMonth()
      end: (new Date).getMonth()
      scale: 'Saffir-Simpson'
      strength: 'Category 5'
      captures: [0...50]
      windSpeeds: ((Math.random() * 150) for i in [0...50])
      pressures: ((Math.random() * 60) + 900 for i in [0...50])

    @content = 'Loading stats...'

    @el.addClass 'stats'
    @content = template @storm

  render: =>
    super

    @map = new Map
      el: @el.find '.path .map'

    @windSpeedGraph = new BarGraph
      el: @el.find '.wind-speed .graph'
      x: 'Date': @storm.captures
      y: 'kt': @storm.windSpeeds

    @pressureGraph = new BarGraph
      el: @el.find '.pressure .graph'
      x: 'Date': @storm.captures
      y: 'mb': @storm.pressures
      floor: Math.floor 0.95 * Math.min @storm.pressures...

  open: =>
    super

    setTimeout @map.resize

module.exports = StatsDialog
