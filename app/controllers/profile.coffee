Spine = require 'spine'
Map = require 'zooniverse/lib/map'
LoginForm = require 'zooniverse/lib/controllers/login_form'
User = require 'zooniverse/lib/models/user'
Favorite = require 'zooniverse/lib/models/favorite'
Recent = require 'zooniverse/lib/models/recent'
CycloneSubject = require 'models/cyclone_subject'
{randomPropertyFrom} = CycloneSubject

class Profile extends Spine.Controller
  map: null

  favoriteMapLabels: null
  recentMapLabels: null

  favPage: 1
  recPage: 1

  events:
    'mouseenter .favorites li': 'onMouseEnterFavorite'
    'mouseleave .favorites li': 'onMouseLeaveFavorite'
    'click .favorites button[name="more"]': 'onClickMoreFavorites'
    'click .favorites button[name="reveal"]': 'onClickReveal'
    'click .favorites img': 'onClickReveal'
    'click .favorites button[name="remove-favorite"]': 'onClickRemove'
    'click button[name="more-recents"]': 'onClickMoreRecents'

  elements:
    '.login-form': 'loginFormContainer'
    '.current-user': 'currentUser'
    '.classification-count': 'classificaionCount'
    '.favorites ul': 'favoritesList'
    '.favorites [data-favorite="TEMPLATE"]': 'favoriteTemplate'

  constructor: ->
    super

    @loginForm = new LoginForm el: @loginFormContainer

    @favoriteMapLabels = {}
    @recentMapLabels = {}

    @map ?= new Map
      latitude: 33
      longitude: -60
      centerOffset: [0.25, 0.5]
      zoom: 3
      className: 'full-screen'

    @map.el.prependTo @el

    @favoriteTemplate.remove()

    @onUserSignIn()
    User.bind 'sign-in', @onUserSignIn

    # TODO: Why do I have to wait so long after fetching
    # for recents and favorites to be available?

    Favorite.bind 'fetch destroy', =>
      setTimeout @updateFavorites, 500

    Recent.bind 'fetch', =>
      setTimeout @updateRecents, 500

  onUserSignIn: =>
    return unless User.current
    @currentUser.html User.current.name
    @classificaionCount.html User.current.project.classification_count
    Favorite.fetch page: @favPage, per_page: 20
    Recent.fetch page: @recPage, per_page: 20

  onClickMoreFavorites: =>
    @favPage += 1
    Favorite.fetch page: @favPage, per_page: 20

  updateFavorites: =>
    console.log 'Favorites fetched', Favorite.count()

    @favoritesList.empty()
    @map.removeLabel label for id, label of @favoriteMapLabels

    favorites = Favorite.all()
    for fav in favorites
      favItem = @favoriteTemplate.clone()
      favItem.attr 'data-favorite': fav.id

      subject = fav.subjects
      continue unless subject.metadata?
      lat = subject.metadata.lat || subject.metadata.map_lat
      lng = subject.metadata.lng || subject.metadata.map_lng

      favItem.find('img').attr src: subject.location[randomPropertyFrom subject.location, /[^yesterday]$/]
      favItem.find('.name').html subject.metadata.name
      favItem.find('.year').html subject.metadata.year
      favItem.find('.date').html subject.metadata.iso_time
      favItem.find('.latitude').html lat.toString()[0..5]
      favItem.find('.longitude').html lng.toString()[0..5]

      favItem.find('a.talk').attr href:
        CycloneSubject::talkHref.call zooniverseId: subject.zooniverse_id

      favItem.appendTo @favoritesList

      @favoriteMapLabels[fav.id] = @map.addLabel lat, lng, """
        #{subject.metadata.name} (#{subject.metadata.year})<br />
        #{subject.metadata.iso_time}<br />
        #{lat.toString()[0..8]}, #{lng.toString()[0..8]}
      """

  onMouseEnterFavorite: ({currentTarget}) =>
    favID = $(currentTarget).attr 'data-favorite'
    @favoriteMapLabels[favID].setRadius 10

  onMouseLeaveFavorite: ({currentTarget}) =>
    favID = $(currentTarget).attr 'data-favorite'
    @favoriteMapLabels[favID].setRadius 5

  onClickReveal: ({currentTarget}) =>
    favRoot = $(currentTarget).closest '[data-favorite]'
    favID = favRoot.attr 'data-favorite'
    label = @favoriteMapLabels[favID]
    {lat, lng} = label.getLatLng()
    @map.setCenter lat, lng

  onClickMoreRecents: =>
    @recPage += 1
    Recent.fetch page: @recPage, per_page: 20

  updateRecents: =>
    console.log 'Recents fetched', Recent.count()
    @map.removeLabel label for id, label of @recentMapLabels
    for recent in Recent.all()
      subject = recent.subjects
      continue unless subject.metadata?
      lat = subject.metadata.lat || subject.metadata.map_lat
      lng = subject.metadata.lng || subject.metadata.map_lng
      @recentMapLabels[recent.id] = @map.addLabel lat, lng, """
        #{subject.metadata.name} (#{subject.metadata.year})<br />
        #{subject.metadata.iso_time}<br />
        #{lat.toString()[0..8]}, #{lng.toString()[0..8]}
      """

  onClickRemove: ({currentTarget}) =>
    parent = $(currentTarget).parents '[data-favorite]'
    favoriteId = parent.attr 'data-favorite'
    favorite = Favorite.find favoriteId
    favorite.unfavorite()

module.exports = Profile
