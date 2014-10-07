BaseController = require 'zooniverse/controllers/base-controller'
Subject = require 'zooniverse/models/subject'
Classification = require 'zooniverse/models/classification'
translate = require 't7e'

class UserProgress extends BaseController
  className: 'user-progress'
  template: require '../views/progress'

  requestedClassifications: 4

  events:
    'click button[name="close"]': 'onClickClose'

  elements:
    '#progress-bar': 'progressBar'
    '.container': 'container'
    '.container p': 'progressText'

  constructor: ->
    super
    Subject.on 'select', @onNextSubject

  onNextSubject: =>
    progress = Math.min (Classification.sentThisSession / @requestedClassifications), 1
    @updateText(progress)
    @progressBar.css
      'width': "#{ progress * 100 }%"

  updateText: (progress) ->
    switch +progress
      when 0.25 then @progressText.html(translate 'span', 'progress.25')
      when 0.50 then @progressText.html(translate 'span', 'progress.50')
      when 0.75 then @progressText.html(translate 'span', 'progress.75')
      when 1.00
        @progressText.html(translate 'span', 'progress.100')
        setTimeout (=> @onClickClose()), 5000

  onClickClose: =>
    @container.slideUp(350)

module.exports = UserProgress
