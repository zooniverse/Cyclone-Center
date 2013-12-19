Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/classify'
Dialog = require 'zooniverse/controllers/dialog'
loginDialog = require 'zooniverse/controllers/login-dialog'
signUpDialog = require 'zooniverse/controllers/signup-dialog'
User = require 'zooniverse/models/user'
{Tutorial} = require 'zootorial'
tutorialSteps = require '../lib/tutorial-steps'
Subject = require 'zooniverse/models/subject'
getTutorialSubject = require '../lib/get-tutorial-subject'
Classification = require 'zooniverse/models/classification'
Favorite = require 'zooniverse/models/favorite'
StormStatus = require './storm-status'
featuredStorms = require '../../public/js/featured-storms'
$ = window.jQuery

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

noMoreSubjectsDialog = new Dialog
  content: '''
    <p>There are no more subjects to classify! Try another storm.</p>
    <button name="close-dialog">OK</button>
  '''

grabRandomSatellite = (subject) ->
  list = subject.metadata.available_satellites
  list[Math.floor(Math.random() * list.length)]

class Classify extends Controller
  className: 'classify'
  template: template

  steps: null
  step: ''

  tutorial: null

  classification: null

  events:
    'click button[name="restart"]': 'onClickRestart'
    'click button[name="continue"], button[name="finish"]': 'onClickContinue'
    'click button[name="next"]': 'onClickNext'
    'click button[name="restart-tutorial"]': 'onClickRestartTutorial'
    'click button[name="favorite"]': 'onClickFavorite'
    'click button[name="unfavorite"]': 'onClickUnfavorite'
    'click .not-signed-in .sign-in': -> loginDialog.show()
    'click .not-signed-in .sign-up': -> signUpDialog.show()

  elements:
    '.subject .older': 'olderImg'
    '.subject .current': 'currentImg'
    '.step-controls': 'stepControls'
    'button[name="continue"]': 'continueButton'
    '.step-details': 'detailsContainer'
    '.talk-image': 'talkImageLink'
    '.talk-storm': 'talkStormLink'
    '.facebook': 'facebookLink'
    '.twitter': 'twitterLink'

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

    @tutorial = new Tutorial
      parent: @el
      id: 'new_tutorial'
      steps: tutorialSteps
      firstStep: 'welcome'

    $(window).on 'hashchange', =>
      setTimeout (=> @tutorial.attach()), 50

  onUserChange: (e, user) =>
    @el.toggleClass 'signed-in', user?

    tutorialDone = !!user?.project.tutorial_done
    noClassification = not @classification?
    tutorialSubject = !!Subject.current?.metadata.tutorial

    if tutorialDone and (noClassification or tutorialSubject)

      group = user?.preferences?.cyclone_center?.storm

      if "#{group}" is 'true'
        group = true
      else if group not in featuredStorms
        group = featuredStorms[Math.floor Math.random() * featuredStorms.length]

      StormStatus::select.call {group}

      @tutorial.end() if @tutorial.started?
    else
      unless @tutorial.started?
        getTutorialSubject().select()
        @tutorial.start()
        setTimeout (=> @tutorial.attach()), 100

  onGettingNextSubject: =>
    @el.addClass 'loading'

  onSubjectSelect: (e, subject) =>
    @el.removeClass 'loading'

    @tutorial.end() unless subject.metadata.tutorial
    @classification?.destroy()

    @classification = new Classification {subject}
    @classification.on 'change', @onClassificationChange

    @favorite = new Favorite subjects: [subject]

    satellite = grabRandomSatellite subject
    @currentImg.attr src: subject.location[satellite]


    @el.toggleClass 'southern', subject.coords[0] < 0

    # return @goToStep 'reveal'

    olderLocation = subject.location["#{satellite}-yesterday"]

    if olderLocation?
      @olderImg.attr src: olderLocation
      @goToStep 'stronger'
    else
      @goToStep 'catAndMatch'

    @classification.set 'satellite', satellite

    @talkImageLink.attr href: subject.talkHref()
    @facebookLink.attr href: subject.facebookHref()
    @twitterLink.attr href: subject.twitterHref()

  onNoMoreSubjects: =>
    @el.removeClass 'loading'
    dialog = new Dialog content: '''
      <p>
        <strong>Sorry</strong>, this storm has run out of subjects<br />
        Pick another storm from the list on the homepage.</br />
      </p>
      <p>
        Or you can <a href="http://talk.cyclonecenter.org/">chat on Talk</a> for a while.
      </p>

      <p class="action">
        <button name="close-dialog">OK</button>
      </p>
    '''

    dialog.show()

    # noMoreSubjectsDialog.show()

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

  onClickRestart: ->
    hadStrength = @classification.get 'strength'

    properties = []
    properties = properties.concat step.property for _, step of @steps when step.property

    for property in properties
      @classification.set property, null

    if hadStrength
      @goToStep 'stronger'
    else
      @goToStep 'catAndMatch'

  onClickContinue: ->
    @goToStep @getNextStep()

  getNextStep: ->
    category = @classification.get @steps.catAndMatch.property[0]

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
    return if step is @step

    @steps[@step]?.leave()
    @step = step

    @el.attr 'data-step', @step
    @steps[@step].enter()

    if @steps[@step].property
      setTimeout (=> @continueButton.attr disabled: true), 250

  onClickNext: ->
    Subject.next()

  onClickRestartTutorial: ->
    getTutorialSubject().select()
    @tutorial.start()

  onClickFavorite: ->
    @favorite.send().then => @el.addClass 'favorited'

  onClickUnfavorite: ->
    @favorite.delete().then => @el.removeClass 'favorited'

module.exports = Classify
