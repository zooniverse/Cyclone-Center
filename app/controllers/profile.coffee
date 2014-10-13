ZooniverseProfile = require 'zooniverse/controllers/profile'
profileItemTemplate = require '../views/profile-item-template'
User = require 'zooniverse/models/user'
translate = require 't7e'

class Profile extends ZooniverseProfile
  template: require '../views/profile'
  recentTemplate: profileItemTemplate
  favoriteTemplate: profileItemTemplate

  elements:
    '#profile-status': 'profileStatus'
    '#greeting': 'greeting'
    '#classification-count': 'classificationCount'
    '#favorite-count': 'favoriteCount'
    'button[name="turn-page"]': 'pageTurners'

  constructor: ->
    super
    User.on 'change', (e, user) =>
      if user
        @profileStatus.show()
        @greeting.html "#{ translate 'span', 'profile.hello'}, #{ user.name }!"
        @classificationCount.html "<p>#{ user.project.classification_count || 0 }</p> <p>#{ translate 'profile.imageCount' }</p"
        @favoriteCount.html "<p>#{ user.project.favorite_count || 0 }</p> <p>#{ translate 'profile.favoriteCount' }</p>"

    User.on 'logging-out', =>
      @profileStatus.children().empty()
      @profileStatus.hide()



 module.exports = Profile
