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
SurroundingStep = require './classify-steps/surrounding'
ExceedingStep = require './classify-steps/exceeding'
FeatureStep = require './classify-steps/feature'
BlueStep = require './classify-steps/blue'
CurveStep = require './classify-steps/curve'
RedStep = require './classify-steps/red'
RevealStep = require './classify-steps/reveal'

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
    'click button[name="continue"], button[name="finish"]': 'onClickContinue'
    'click button[name="next"]': 'onClickNext'

  elements:
    '.subject .older': 'olderImg'
    '.subject .current': 'currentImg'
    '.step-controls': 'stepControls'
    'button[name="continue"]': 'continueButton'
    '.step-details': 'detailsContainer'

  constructor: ->
    super

    @el.addClass 'loading'

    User.on 'change', @onUserChange

    Subject.on 'get-next', @onGettingNextSubject
    Subject.on 'select', @onSubjectSelect
    Subject.on 'no-more', @onNoMoreSubjects

    @steps =
      stronger: (new StrongerStep classifier: @)
      catAndMatch: (new MatchStep classifier: @)
      center: (new CenterStep classifier: @)
      centerEyeSize: (new CenterEyeSizeStep classifier: @)
      surrounding: (new SurroundingStep classifier: @)
      exceeding: (new ExceedingStep classifier: @)
      feature: (new FeatureStep classifier: @)
      blue: (new BlueStep classifier: @)
      curve: (new CurveStep classifier: @)
      red: (new RedStep classifier: @)
      reveal: (new RevealStep classifier: @)

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

    return @goToStep 'reveal'

    if olderLocation?
      @olderImg.attr src: olderLocation
      @goToStep 'stronger'
    else
      @goToStep 'catAndMatch'

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
    @goToStep @getNextStep()

  getNextStep: ->
    category = @classification.get 'category'

    switch @step
      when 'stronger' then 'catAndMatch'

      when 'catAndMatch'
        switch category
          when 'eye' then 'centerEyeSize'
          when 'other' then 'reveal'
          else 'center'

      when 'centerEyeSize' then 'surrounding'

      when 'center'
        switch category
          when 'embedded' then 'feature'
          when 'curved' then 'blue'
          when 'shear' then 'red'
          when 'other' then 'reveal'

      when 'surrounding' then 'exceeding'

      when 'exceeding' then 'feature'

      when 'feature' then 'reveal'

      when 'blue' then 'curve'

      when 'curve' then 'reveal'

      when 'red' then 'reveal'

  goToStep: (step) ->
    @steps[@step]?.leave()
    @step = step

    @el.attr 'data-step', @step
    @steps[@step].enter()

    if @steps[@step].property
      @continueButton.attr disabled: true

  onClickNext: ->
    Subject.next()

module.exports = Classify
