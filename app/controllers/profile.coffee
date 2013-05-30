ZooniverseProfile = require 'zooniverse/controllers/profile'
profileItemTemplate = require '../views/profile-item-template'

class Profile extends ZooniverseProfile
  recentTemplate: profileItemTemplate
  favoriteTemplate: profileItemTemplate

module.exports = Profile
