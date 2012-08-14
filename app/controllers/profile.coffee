Spine = require('spine')
Map = require('zooniverse/lib/map')

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
      latitude: 33
      longitude: -60
      zoom: 5
      className: 'full-screen'

    @map.el.prependTo @el

    @favoriteTemplate.remove()

    setTimeout @updateFavorites, 1000

  updateFavorites: (favorites) =>
    # JUST FOR TESTING
    favorites ?= window.classifier.recentClassifications

    for fav in favorites
      favItem = @favoriteTemplate.clone()
      favItem.attr 'data-favorite': fav.subject.id
      favItem.find('img').attr src: fav.subject.location.standard
      favItem.find('.date').html fav.subject.metadata.captured.toString().split(' ')[1..4].join ' '
      favItem.find('.latitude').html fav.subject.coords[0]
      favItem.find('.longitude').html fav.subject.coords[1]
      favItem.appendTo @favoritesList

      @labels[fav.subject.id] = @map.addLabel fav.subject.coords...,  fav.subject.coords.join ', '

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
