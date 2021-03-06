Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/classify'
Dialog = require 'zooniverse/controllers/dialog'
loginDialog = require 'zooniverse/controllers/login-dialog'
signUpDialog = require 'zooniverse/controllers/signup-dialog'
User = require 'zooniverse/models/user'
translate = require 't7e'
{Tutorial} = require 'zootorial'
SlideTutorial = require 'slide-tutorial'
slideTutorialSlides = require '../lib/slide-tutorial-slides'
tutorialSteps = require '../lib/tutorial-steps'
Subject = require 'zooniverse/models/subject'
getTutorialSubject = require '../lib/get-tutorial-subject'
Classification = require 'zooniverse/models/classification'
Favorite = require 'zooniverse/models/favorite'
LanguageManager = require 'zooniverse/lib/language-manager'

StormStatus = require './storm-status'
StackOfPages = require 'stack-of-pages'
ProgressBar = require './progress-bar'
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

createSatelliteTalkHref = (subject, satellite) ->
  subjectTalkHref = subject.talkHref()
  satelliteTalkHref = subjectTalkHref.replace '#', "?satellite=#{ satellite }#"
  return satelliteTalkHref

class Classify extends Controller
  className: 'classify'
  template: template

  steps: null
  step: ''

  tutorial: null

  classification: null

  events:
    'click button[name="restart"]': 'onClickRestart'
    'click button[name="go-to-guide"]': 'onClickGoToGuide'
    'click button[name="continue"], button[name="finish"]': 'onClickContinue'
    'click button[name="slide-tutorial"]': 'onClickSlideTutorial'
    'click button[name="next"]': 'onClickNext'
    'click button[name="restart-tutorial"]': 'onClickRestartTutorial'
    'click button[name="favorite"]': 'onClickFavorite'
    'click button[name="unfavorite"]': 'onClickUnfavorite'
    'click .not-signed-in .sign-in': -> loginDialog.show()
    'click .not-signed-in .sign-up': -> signUpDialog.show()
    'click .scroll-up': 'onClickScrollUp'

  elements:
    '.subject .older': 'olderImg'
    '.subject .current': 'currentImg'
    '.step-controls': 'stepControls'
    'button[name="continue"]': 'continueButton'
    '.step-details': 'detailsContainer'
    '.classify-header': 'classifyHeader'
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
      steps: tutorialSteps
      firstStep: 'welcome'

    @siteIntro = new SlideTutorial
      slides: slideTutorialSlides()
      nextButtonText: translate('span', 'siteIntro.nextButtonText')
      finishButtonText: translate('span', 'siteIntro.finishButtonText')

    LanguageManager.on 'change-language', =>
      @siteIntro.nextButtonText = translate('span', 'siteIntro.nextButtonText')
      @siteIntro.finishButtonText = translate('span', 'siteIntro.finishButtonText')
      @siteIntro.slides = slideTutorialSlides()
      @siteIntro._createSlides()

    @progress = new ProgressBar
    @el.prepend @progress.el

    @el.on StackOfPages::activateEvent, @introIfFirstVisit

  onClassifyPage: ->
    location.hash is '#/classify'

  firstVisit: (user) ->
    return false if user is false
    return true unless user
    !user?.project?.classification_count

  onUserChange: (e, user) =>
    @el.toggleClass 'signed-in', user?
    Subject.next()
    @introIfFirstVisit() if @onClassifyPage()
    @progressIfFirstVisit(user)

  introIfFirstVisit: =>
    @startSlideTutorial() if @firstVisit User.current

  progressIfFirstVisit: (user) ->
    firstVisit = @firstVisit(user)

    @progress.el.toggle(firstVisit)
    @classifyHeader.toggle(not firstVisit)

  startSlideTutorial: =>
    @siteIntro.start()

  onGettingNextSubject: =>
    @el.addClass 'loading'

  onClickSlideTutorial: =>
    @startSlideTutorial()

  onSubjectSelect: (e, subject) =>
    @el.removeClass 'loading'

    @classification?.destroy()

    @classification = new Classification {subject}
    @classification.on 'change', @onClassificationChange

    @favorite = new Favorite subjects: [subject]

    satellite = grabRandomSatellite subject
    @currentImg.attr src: subject.location[satellite]

    @el.toggleClass 'southern', subject.coords[0] < 0

    olderLocation = subject.location["#{satellite}-yesterday"]

    if olderLocation?
      @olderImg.attr src: olderLocation
      @goToStep 'stronger'
    else
      @goToStep 'catAndMatch'

    @classification.set 'satellite', satellite

    @talkImageLink.attr href: createSatelliteTalkHref subject, satellite
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
        Or you can <a href="https://talk.cyclonecenter.org/">chat on Talk</a> for a while.
      </p>

      <p class="action">
        <button name="close-dialog">OK</button>
      </p>
    '''

    dialog.show()

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

  onClickGoToGuide: ->
    $('html, body').animate
      scrollTop: $('.step-details').offset().top - 200, 500

  onClickContinue: ->
    @goToStep @getNextStep()

  onClickScrollUp: ->
    $('html, body').animate
      scrollTop: $('html, body').offset().top, 500

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
    @el.removeClass 'favorited'
    Subject.next()

  onClickRestartTutorial: ->
    getTutorialSubject().select()
    @tutorial.start()
    translate.refresh()

  onClickFavorite: ->
    @favorite.send().then => @el.addClass 'favorited'

  onClickUnfavorite: ->
    @favorite.delete().then => @el.removeClass 'favorited'

module.exports = Classify
