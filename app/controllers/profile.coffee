Spine = require('spine')
Map = require('Zooniverse/lib/map')

TEST =
  favorites: [
    {id: 0, subjects: [{id: 0, location: {standard: 'http://placehold.it/1/0f0.png'}, coords: [28, -70], metadata: {type: 'Hurricane', name: 'Katrina', year: 2005}}]}
    {id: 1, subjects: [{id: 0, location: {standard: 'http://placehold.it/1/0f0.png'}, coords: [27, -70], metadata: {type: 'Hurricane', name: 'Charlie', year: 2006}}]}
    {id: 3, subjects: [{id: 0, location: {standard: 'http://placehold.it/1/0f0.png'}, coords: [26, -70], metadata: {type: 'Hurricane', name: 'Ivan', year: 2007}}]}
  ]

class Profile extends Spine.Controller
  map: null

  labels: null

  events:
    'mouseenter .favorites li': 'onMouseEnterFavorite'
    'mouseleave .favorites li': 'onMouseLeaveFavorite'
    'click .favorites button[name="reveal"]': 'onClickReveal'
    'click .favorites img': 'onClickReveal'

  elements:
    '.favorites ul': 'favoritesList'
    '.favorites [data-favorite="TEMPLATE"]': 'favoriteTemplate'

  constructor: ->
    super

    @labels = {}

    @map ?= new Map
      apiKey: '21a5504123984624a5e1a856fc00e238'
      latitude: 33
      longitude: -60
      zoom: 5
      className: 'full-screen'

    @map.el.prependTo @el

    @favoriteTemplate.remove()

    @updateFavorites()

  updateFavorites: =>
    for fav in TEST.favorites
      favItem = @favoriteTemplate.clone()
      favItem.attr 'data-favorite': fav.id
      favItem.appendTo @favoritesList

      coords = fav.subjects[0].coords
      @labels[fav.id] = @map.addLabel coords...,  coords.join ', '

  onMouseEnterFavorite: ({currentTarget}) =>
    favID = $(currentTarget).attr 'data-favorite'
    @labels[favID].el.addClass 'hovering'

  onMouseLeaveFavorite: ({currentTarget}) =>
    favID = $(currentTarget).attr 'data-favorite'
    @labels[favID].el.removeClass 'hovering'

  onClickReveal: ({currentTarget}) =>
    favRoot = $(currentTarget).closest '[data-favorite]'
    favID = favRoot.attr 'data-favorite'
    label = @labels[favID]
    {lat, lng} = label.getLatLng()
    @map.setCenter lat, lng, center: [0.25, 0.5]

module.exports = Profile
