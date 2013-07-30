Step = require './base-step'
detailsTemplate = require '../../views/classify-steps/reveal'
$ = window.jQuery
Leaflet = window.L
Api = require 'zooniverse/lib/api'
translate = require 't7e'

LEAFLET_API_KEY = '21a5504123984624a5e1a856fc00e238' # Brian's
DEFAULT_ZOOM = 3

# Used to determine how big to draw each storm's dot
SMALLEST_DOT = 2
LARGEST_DOT = 20
MIN_INTENSITY = 20
MAX_INTENSITY = 150

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

    @trail = []

    @youAreHere = new Leaflet.CircleMarker [0, 0]
    @youAreHere.setRadius 10
    @youAreHere.setStyle fill: 'rgba(0, 0, 0, 0.1)', color: 'red'

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
      @map.invalidateSize()
      @chart.setSize @graphContainer.width(), @graphContainer.height()

  enter: ->
    super

    @map.invalidateSize()
    @chart.setSize @graphContainer.width(), @graphContainer.height()

    @classifier.classification.send()
    console?.log 'Sent classification', JSON.stringify @classifier.classification

    getStorm = Api.current.get "/projects/cyclone_center/groups/#{@classifier.classification.subject.group_id}"
    getStorm.then (storm) =>
      # TODO: This is really ugly, and it's a weird place to do it.
      @classifier.talkStormLink.attr
        href: @classifier.classification.subject.talkHref.call(zooniverse_id: storm.zooniverse_id).replace 'subjects', 'groups'

      @stormNameContainer.html storm.name

      if @classifier.classification.subject.metadata.tutorial
        @stormNameContainer.append '\n'
        @stormNameContainer.append translate 'span.tutorial-note', 'classify.details.reveal.tutorialSubject'

      categories = []

      lastLng = NaN
      for {time, lat, lng, wind, pressure} in storm.metadata.stats
        # Ignore any crazy data.
        continue if Math.abs(Math.abs(lastLng) - Math.abs(lng)) > 45
        lastLng = lng

        lng += 360 if lng < 0 # 0 through 360 instead of -180 through +180

        theWind = if wind.wmo is 0 then null else wind.wmo
        thePressure = if pressure.wmo < 850 then null else pressure.wmo

        @chart.series[0].addPoint theWind, false
        # @chart.series[1].addPoint [wind.min, wind.max], false
        @chart.series[1].addPoint thePressure, false
        # @chart.series[3].addPoint [pressure.min, pressure.max], false
        categories.push time

        @trail.push do =>
          point = new Leaflet.CircleMarker [lat, lng]
          point.setRadius ((LARGEST_DOT - SMALLEST_DOT) * (theWind / (MAX_INTENSITY - MIN_INTENSITY))) + SMALLEST_DOT
          point.setStyle fill: 'black', color: 'black', stroke: false
          @map.addLayer point
          point

        @youAreHere.bringToFront()

      # @chart.axes[0].setCategories categories

      setTimeout =>
        @chart.setSize @graphContainer.width(), @graphContainer.height()
        @chart.redraw()

      [lat, lng] = @classifier.classification.subject.coords

      displayLat = lat

      lng += 360 if lng < 0

      @youAreHere.setLatLng [lat, lng]

      popupContent = """
        <p>
          #{Math.abs displayLat} #{if displayLat < 0 then 'S' else 'N'},
          #{Math.abs lng} #{if lng < 0 then 'W' else 'E'}
        </p>
      """

      speedEstimate = SPEED_ESTIMATES[@classifier.classification.get 'match']
      if speedEstimate?
        popupContent += "<p>#{translate 'span', 'classify.details.reveal.estimated'} #{speedEstimate}</p>"

      @youAreHere.bindPopup(popupContent).openPopup()

      @map.setView [lat, lng], DEFAULT_ZOOM

  reset: ->
    super

    @map.removeLayer point for point in @trail
    @trail.splice 0

    series.setData [] for series in @chart.series

module.exports = Reveal
