Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/classify'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'
Classification = require 'zooniverse/models/classification'
$ = require 'jqueryify'

StrongerStep = require './classify-steps/stronger'
MatchStep = require './classify-steps/match'
CenterStep = require './classify-steps/center'
CenterEyeSizeStep = require './classify-steps/center-eye-size'

grabRandomSatellite = (subject) ->
  satellites = for satellite of subject.location
    continue if !!~satellite.indexOf 'yesterday'
    satellite

  satellites[Math.floor Math.random() * satellites.length]

class Classify extends Controller
  className: 'classify'
  template: template

  steps: null
  step: ''

  classification: null

  events:
    'click button[name="continue"]': 'onClickContinue'

  elements:
    '.subject .older': 'olderImg'
    '.subject .current': 'currentImg'
    '.step-controls': 'stepControls'
    'button[name="continue"]': 'continueButton'

  constructor: ->
    super

    @el.addClass 'loading'

    User.on 'change', @onUserChange

    Subject.on 'get-next', @onGettingNextSubject
    Subject.on 'select', @onSubjectSelect
    Subject.on 'no-more', @onNoMoreSubjects

    @steps =
      stronger: (new StrongerStep classifier: @)
      match: (new MatchStep classifier: @)
      center: (new CenterStep classifier: @)
      centerEyeSize: (new CenterEyeSizeStep classifier: @)

  onUserChange: (e, user) ->
    Subject.next()

  onGettingNextSubject: =>
    @el.addClass 'loading'

  onSubjectSelect: (e, subject) =>
    @el.removeClass 'loading'

    @classification = new Classification {subject}
    @classification.on 'change', @onClassificationChange

    satellite = grabRandomSatellite subject
    @currentImg.attr src: subject.location[satellite]

    olderLocation = subject.location["#{satellite}-yesterday"]

    return @goToStep 'centerEyeSize'

    if olderLocation?
      @olderImg.attr src: olderLocation
      @goToStep 'stronger'
    else
      @goToStep 'match'

  onNoMoreSubjects: =>
    @el.removeClass 'loading'

  onClassificationChange: (e, key, value) =>
    requiredProperty = @steps[@step].property
    disabled = if requiredProperty instanceof Array
      set = (true for property in requiredProperty when @classification.get(property)?)
      set.length isnt requiredProperty.length
    else if requiredProperty
      not @classification.get(requiredProperty)?
    else
      false

    @continueButton.attr {disabled}

  onClickContinue: ->
    match = @classification.get 'match'

  goToStep: (step) ->
    @steps[@step]?.leave()
    @step = step

    @el.attr 'data-step', @step
    @steps[@step].enter()

    if @steps[@step].property
      @continueButton.attr disabled: true

module.exports = Classify
