ZooniverseProfile = require 'zooniverse/controllers/profile'
profileItemTemplate = require '../views/profile-item-template'
User = require 'zooniverse/models/user'
translate = require 't7e'

class Profile extends ZooniverseProfile
  template: require '../views/profile'
  recentTemplate: profileItemTemplate
  favoriteTemplate: profileItemTemplate

  elements:
    '#greeting': 'greeting'
    '#classification-count': 'classificationCount'
    '#favorite-count': 'favoriteCount'
    'button[name="turn-page"]': 'pageTurners'

  constructor: ->
    super
    setTimeout =>
      user = User.current
      if user
        @greeting.html "#{ translate 'span', 'profile.hello'}, #{User.current.name}!"
        @classificationCount.html user.project.classification_count || 0
        @favoriteCount.html user.project.favorite_count || 0
    , 1000

 module.exports = Profile
