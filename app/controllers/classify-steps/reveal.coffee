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

  enter: ->
    super
    @map.invalidateSize()

    getStorm = Api.current.get "https://dev.zooniverse.org/projects/cyclone_center/groups/5057531d516bcb571700001d"
    getStorm.then (storm) =>
      @stormNameContainer.html storm.name

      for {lat, lng} in storm.metadata.stats
        @trail.addLatLng [lat, lng]

      @youAreHere.setLatLng @classifier.classification.subject.coords
      @map.setView @classifier.classification.subject.coords, DEFAULT_ZOOM

  reset: ->
    super
    @trail.spliceLatLngs 0

module.exports = Reveal
