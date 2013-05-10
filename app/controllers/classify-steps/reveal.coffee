Step = require './base-step'
detailsTemplate = require '../../views/classify-steps/reveal'
$ = window.jQuery
Leaflet = window.L
Api = require 'zooniverse/lib/api'

LEAFLET_API_KEY = '21a5504123984624a5e1a856fc00e238' # Brian's
DEFAULT_ZOOM = 3

class Reveal extends Step
  explanation: detailsTemplate @

  map: null
  trail: null
  youAreHere: null

  chart: null

  elements:
    '.storm-name': 'stormNameContainer'
    '.map': 'mapContainer'
    '.graph': 'graphContainer'

  constructor: ->
    super
    window.reveal = @

    @map = new Leaflet.Map @mapContainer.get 0
    @map.setView [51.505, -0.09], DEFAULT_ZOOM
    @map.addLayer new Leaflet.TileLayer "http://{s}.tile.cloudmade.com/#{LEAFLET_API_KEY}/997/256/{z}/{x}/{y}.png"

    @trail = new Leaflet.Polyline []
    @trail.setStyle color: 'orange'
    @youAreHere = new Leaflet.CircleMarker [0, 0]
    @youAreHere.setRadius 10
    @youAreHere.setStyle fill: false, color: 'red'

    @map.addLayer @trail
    @map.addLayer @youAreHere

    @chart = new Highcharts.Chart
      chart:
        type: 'spline'
        renderTo: @graphContainer.get 0

      title:
        text: ''

      xAxis:
        labels:
          rotation: -45
      series: [
        {name: 'Wind'}
        {name: 'Wind range', type: 'errorbar'}
        {name: 'Pressure'}
        {name: 'Pressure range', type: 'errorbar'}
      ]

      tooltip:
        shared: true

  enter: ->
    super
    @map.invalidateSize()
    @chart.setSize @graphContainer.width(), @graphContainer.height()

    getStorm = Api.current.get "https://dev.zooniverse.org/projects/cyclone_center/groups/5057531d516bcb571700001d"
    getStorm.then (storm) =>
      @stormNameContainer.html storm.name

      # console.log 'Stats', storm.metadata.stats

      categories = []

      for {time, lat, lng, wind, pressure} in storm.metadata.stats
        @trail.addLatLng [lat, lng]

        @chart.series[0].addPoint wind.wmo
        @chart.series[1].addPoint [wind.min, wind.max]
        @chart.series[2].addPoint pressure.wmo
        @chart.series[3].addPoint [pressure.min, pressure.max]
        categories.push time

      # @chart.axes[0].setCategories categories

      @youAreHere.setLatLng @classifier.classification.subject.coords
      @map.setView @classifier.classification.subject.coords, DEFAULT_ZOOM

  reset: ->
    super
    @trail.spliceLatLngs 0
    series.setData [] for series in @chart.series

module.exports = Reveal
