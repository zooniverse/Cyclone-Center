Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/classify'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'

class Classify extends Controller
  className: 'classify'
  template: template

  elements:
    '.controls .step': 'steps'

  constructor: ->
    super

    @el.addClass 'loading'

    User.on 'change', @onUserChange

    Subject.on 'get-next', @onGettingNextSubject
    Subject.on 'select', @onSubjectSelect
    Subject.on 'no-more', @onNoMoreSubjects

  onUserChange: (e, user) ->
    console?.log 'User is now', user
    Subject.next()

  onGettingNextSubject: =>
    @el.addClass 'loading'

  onSubjectSelect: (e, subject) =>
    @el.removeClass 'loading'
    console?.log 'Selected subject', subject

  onNoMoreSubjects: =>
    @el.removeClass 'loading'
    console?.log 'It appears we\'ve run out of data!'

  goToStep: (step) ->
    @el.attr 'data-step', step
    @steps.hide()
    @steps.filter(".#{step}").show()

module.exports = Classify
