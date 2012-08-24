Spine = require 'spine'
Map = require 'zooniverse/lib/map'
LoginForm = require 'zooniverse/lib/controllers/login_form'
User = require 'zooniverse/lib/models/user'
Favorite = require 'zooniverse/lib/models/favorite'
CycloneSubject = require 'models/cyclone_subject'
{randomPropertyFrom} = CycloneSubject

class Profile extends Spine.Controller
  map: null

  labels: null

  events:
    'mouseenter .favorites li': 'onMouseEnterFavorite'
    'mouseleave .favorites li': 'onMouseLeaveFavorite'
    'click .favorites button[name="reveal"]': 'onClickReveal'
    'click .favorites img': 'onClickReveal'
    'click .favorites button[name="remove-favorite"]': 'onClickRemove'

  elements:
    '.login-form': 'loginFormContainer'
    '.current-user': 'currentUser'
    '.classification-count': 'classificaionCount'
    '.favorites ul': 'favoritesList'
    '.favorites [data-favorite="TEMPLATE"]': 'favoriteTemplate'

  constructor: ->
    super

    @loginForm = new LoginForm el: @loginFormContainer

    @labels = {}

    @map ?= new Map
      latitude: 33
      longitude: -60
      zoom: 5
      className: 'full-screen'

    @map.el.prependTo @el

    @favoriteTemplate.remove()

    @onUserSignIn()
    User.bind 'sign-in', @onUserSignIn

    @updateFavorites()
    Favorite.bind 'fetch create destroy', =>
      setTimeout @updateFavorites, 250

  onUserSignIn: =>
    @currentUser.html User.current?.name
    @classificaionCount.html User.current?.classification_count

  updateFavorites: =>
    @favoritesList.empty()

    favorites = Favorite.all()
    for fav in favorites
      favItem = @favoriteTemplate.clone()
      favItem.attr 'data-favorite': fav.id

      subject = fav.subjects
      lat = subject.metadata.lat || subject.metadata.map_lat
      lng = subject.metadata.lng || subject.metadata.map_lng

      favItem.find('img').attr src: randomPropertyFrom subject.location
      favItem.find('.name').html subject.metadata.name
      favItem.find('.year').html subject.metadata.year
      favItem.find('.date').html subject.metadata.iso_time
      favItem.find('.latitude').html lat
      favItem.find('.longitude').html lng

      favItem.find('a.talk').attr href:
        CycloneSubject::talkHref.call zooniverseId: subject.zooniverse_id

      favItem.appendTo @favoritesList

      @labels[fav.id] = @map.addLabel lat, lng, ''

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

  onClickRemove: ({currentTarget}) =>
    parent = $(currentTarget).parents '[data-favorite]'
    favoriteId = parent.attr 'data-favorite'
    favorite = Favorite.find favoriteId
    favorite.unfavorite()

module.exports = Profile
