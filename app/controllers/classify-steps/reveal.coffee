Step = require './base-step'
detailsTemplate = require '../../views/classify-steps/reveal'
$ = window.jQuery
Leaflet = window.L
Api = require 'zooniverse/lib/api'
translate = require 't7e'

LEAFLET_API_KEY = '21a5504123984624a5e1a856fc00e238' # Brian's
DEFAULT_ZOOM = 3

SPEED_ESTIMATES =
  'eye-4.0': '55-77 kts'
  'eye-5.0': '77-102 kts'
  'eye-6.0': '102-127 kts'
  'eye-7.0': '127-155 kts'
  'eye-8.0': '155+ kts'
  'embed-3.5': '45-65 kts'
  'embed-4.0': '55-77 kts'
  'embed-4.5': '65-90 kts'
  'embed-5.0': '77-102 kts'
  'embed-5.5': '90-115 kts'
  'band-1.5': '25-30 kts'
  'band-2.0': '25-35 kts'
  'band-2.5': '30-45 kts'
  'band-3.0': '35-55 kts'
  'band-3.5': '45-65 kts'
  'shear-1.5': '25-30 kts'
  'shear-2.0': '25-35 kts'
  'shear-2.5': '30-45 kts'
  'shear-3.0': '35-55 kts'
  'shear-3.5': '45-65 kts'

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
    @youAreHere.setStyle fill: 'rgba(0, 0, 0, 0.1)', color: 'red'

    @map.addLayer @trail
    @map.addLayer @youAreHere

    @chart = new Highcharts.Chart
      chart:
        type: 'spline'
        renderTo: @graphContainer.get 0

      title:
        text: ''

      yAxis: [{
        title:
          text: 'Wind speed'
          style: color: 'black'
        labels:
            formatter: -> "#{this.value}kts"
            style: color: ''
      }, {
        opposite: true
        title:
          text: 'Air pressure'
          style: color: 'blue'
        labels:
          formatter: -> "#{this.value}mbar"
          style: color: 'blue'
      }]

      series: [
        {name: 'Wind', color: 'black'}
        # {name: 'Wind range', type: 'errorbar', color: 'gray'}
        {name: 'Pressure', color: 'blue', yAxis: 1}
        # {name: 'Pressure range', type: 'errorbar', yAxis: 1, color: 'gray'}
      ]

      tooltip:
        shared: true

    $(window).on 'hashchange', =>
      # @map.invalidateSize()
      # @chart.setSize @graphContainer.width(), @graphContainer.height()

  enter: ->
    super
    @map.invalidateSize()
    @chart.setSize @graphContainer.width(), @graphContainer.height()

    @classifier.classification.send()
    console?.log 'Sent classification', JSON.stringify @classifier.classification

    getStorm = Api.current.get "https://dev.zooniverse.org/projects/cyclone_center/groups/#{@classifier.classification.subject.group_id}"
    getStorm.then (storm) =>
      @stormNameContainer.html storm.name

      categories = []

      lastLat = null
      lastLng = null

      for {time, lat, lng, wind, pressure} in storm.metadata.stats
        # Ignore any crazy numbers.
        # lat = lastLat if lastLat and Math.abs(lastLat - lat) > 20
        # lng = lastLng if lastLng and Math.abs(lastLng - lng) > 20

        lng += 360 if lng < 0 # 0 through 360 instead of -180 through +180

        [lastLat, lastLng] = [lat, lng]

        @trail.addLatLng [lat, lng]

        @chart.series[0].addPoint wind.wmo, false
        # @chart.series[1].addPoint [wind.min, wind.max], false
        @chart.series[1].addPoint pressure.wmo, false
        # @chart.series[3].addPoint [pressure.min, pressure.max], false
        categories.push time

      # @chart.axes[0].setCategories categories

      setTimeout =>
        @chart.setSize @graphContainer.width(), @graphContainer.height()
        @chart.redraw()

      coords = @classifier.classification.subject.coords
      coords[1] += 360 if coords[1] < 0
      @youAreHere.setLatLng coords
      @youAreHere.bindPopup("""
        <p>#{coords}</p>
        <p>
          #{translate 'span', 'classify.details.reveal.estimated'}<br />
          #{SPEED_ESTIMATES[@classifier.classification.get 'match'] || '?'}
        </p>
      """).openPopup()
      @map.setView @classifier.classification.subject.coords, DEFAULT_ZOOM

  reset: ->
    super
    @trail.spliceLatLngs 0
    series.setData [] for series in @chart.series

module.exports = Reveal
