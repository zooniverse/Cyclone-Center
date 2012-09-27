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
    'click button[name="remove-favorite"]': 'onClickRemoveFavorite'
    'click button[name="more-favorites"]': 'onClickMoreFavorites'
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

    Favorite.bind 'create', @onCreateFavorite
    Favorite.bind 'destroy', @onDestroyFavorite
    Recent.bind 'create', @onCreateRecent
    Recent.bind 'create-group', @onCreateRecentGroup

  onUserSignIn: =>
    @map.removeLabel label for id, label of @recentMapLabels
    @map.removeLabel label for id, label of @favoriteMapLabels
    @favoritesList.empty()

    return unless User.current

    @currentUser.html User.current.name
    @classificaionCount.html User.current.project.classification_count

    Favorite.fetch page: @favPage, per_page: 20
    Recent.fetch page: @recPage, per_page: 20

  onCreateRecent: (recent) =>
    subject = recent.subjects # Not a typo
    metadata = subject.metadata
    lat = metadata.lat || metadata.map_lat
    lng = metadata.lng || metadata.map_lng
    @recentMapLabels[recent.id] = @map.addLabel lat, lng, """
      <strong>#{metadata.name}</strong> (#{metadata.year})<br />
      #{metadata.iso_time}<br />
      #{lat.toString()[0..8]}, #{lng.toString()[0..8]}<br />
      <a href="#{CycloneSubject::talkHref.call zooniverseId: subject.zooniverse_id}">Discuss on Talk</a>
    """

  onCreateRecentGroup: ({number}) =>
    console.log 'Recent group created', number
    @classificaionCount.html +@classificaionCount.html() + number

  onCreateFavorite: (favorite, {fromClassify}) =>
    return unless favorite.subjects.metadata # Created from the UI. Wait for response from server.

    favItem = @favoriteTemplate.clone()
    favItem.attr 'data-favorite': favorite.id

    subject = favorite.subjects # Not a typo
    metadata = subject.metadata
    lat = metadata.lat || metadata.map_lat
    lng = metadata.lng || metadata.map_lng

    favItem.find('img').attr src: subject.location[randomPropertyFrom subject.location, /[^yesterday]$/]
    favItem.find('.name').html metadata.name
    favItem.find('.year').html metadata.year
    favItem.find('.date').html metadata.iso_time
    favItem.find('.latitude').html lat.toString()[0..8]
    favItem.find('.longitude').html lng.toString()[0..8]
    favItem.find('a.talk').attr href:
      CycloneSubject::talkHref.call zooniverseId: subject.zooniverse_id

    if fromClassify
      favItem.prependTo @favoritesList
    else
      favItem.appendTo @favoritesList

  onClickRemoveFavorite: ({currentTarget}) =>
    itemParent = $(currentTarget).parents '[data-favorite]'
    favoriteId = itemParent.attr 'data-favorite'
    favorite = Favorite.find favoriteId
    favorite.unfavorite()

  onDestroyFavorite: (favorite) =>
    @favoritesList.children("[data-favorite='#{favorite.id}']").remove()

  onClickMoreRecents: =>
    @recPage += 1
    Recent.fetch page: @recPage, per_page: 20

  onClickMoreFavorites: =>
    @favPage += 1
    Favorite.fetch page: @favPage, per_page: 20

module.exports = Profile
