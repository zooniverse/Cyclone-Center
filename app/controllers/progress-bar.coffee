BaseController = require 'zooniverse/controllers/base-controller'
Subject = require 'zooniverse/models/subject'
Classification = require 'zooniverse/models/classification'

class UserProgress extends BaseController
  className: 'user-progress'
  template: require '../views/progress'

  requestedClassifications: 4

  events:
    'click button[name="close"]': 'onClickClose'

  elements:
    '#progress-bar': 'progressBar'

  constructor: ->
    super

    Subject.on 'select', @onNextSubject

  onNextSubject: =>
    progress = Math.min (Classification.sentThisSession / @requestedClassifications), 1
    @progressBar.css
      'width': "#{ progress * 100 }%"

  onClickClose: =>
    @el.hide()   

module.exports = UserProgress
