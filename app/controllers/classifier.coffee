Spine = require('spine')
Map = require('Zooniverse/lib/map')
StatsDialog = require('./stats_dialog')

TEST =
  selection: []
  subjects: [
    {id: 0, group: 0, location: {standard: 'http://placehold.it/1/f00.png'}, coords: [24, -70], metadata: {index: 0, remaining: 2}}
    {id: 1, group: 0, location: {standard: 'http://placehold.it/1/ff0.png'}, coords: [26, -70], metadata: {index: 1, remaining: 1}}
    {id: 2, group: 0, location: {standard: 'http://placehold.it/1/0f0.png'}, coords: [28, -70], metadata: {index: 2, remaining: 0, type: 'Hurricane', name: 'Katrina', year: 2005}}

    {id: 3, group: 1, location: {standard: 'http://placehold.it/1/0ff.png'}, coords: [30, -70], metadata: {index: 0, remaining: 2}}
    {id: 4, group: 1, location: {standard: 'http://placehold.it/1/00f.png'}, coords: [32, -70], metadata: {index: 1, remaining: 1}}
    {id: 5, group: 1, location: {standard: 'http://placehold.it/1/f0f.png'}, coords: [34, -70], metadata: {index: 2, remaining: 0, type: 'Hurricane', name: 'Andrew', year: 1992}}
  ]

class Classification
  constructor: ->
    @values = {}
    @emitter = $({})

  annotate: (keyVal) =>
    for key, val of keyVal
      @values[key] = val
      @emitter.trigger "change", [key, val]

  get: (key) =>
    @values[key]

  onChange: (callback) ->
    @emitter.on 'change', (e, key, val) ->
      callback key, val

NORMAL_SIZE = 250
PRO_SIZE = 485

OFF_LEFT = -250
NORMAL_LEFT = 20
PRO_LEFT = 30

OFF_RIGHT = 550
NORMAL_RIGHT = 280
PRO_RIGHT = 150

class Classifier extends Spine.Controller
  events:
    'click .main-pair .subject': 'onClickSubject'

    'click button[name="stronger"]': 'onClickButton'
    'click button[name="category"]': 'onClickButton'
    'click button[name="match"]': 'onClickButton'
    'click button[name="surrounding"]': 'onClickButton'
    'click button[name="exceeding"]': 'onClickButton'
    'click button[name="feature"]': 'onClickButton'
    'click button[name="blue"]': 'onClickButton'

    'click button[name="pro-classify"]': 'onClickProClassify'
    'click button[name="continue"]': 'onClickContinue'
    'click button[name="next-subject"]': 'onClickNext'

  elements:
    '.main-pair .previous': 'previousImage'
    '.main-pair .subject': 'subjectImage'
    '.main-pair .match': 'matchImage'

    'button[name="stronger"]': 'strongerButtons'
    'button[name="category"]': 'categoryButtons'
    '.matches': 'matchListsContainer'
    '.matches > ol': 'matchLists'
    'button[name="match"]': 'matchButtons'
    'button[name="surrounding"]': 'surroundingButtons'
    'button[name="exceeding"]': 'exceedingButtons'
    'button[name="major-feature"]': 'featureButtons'
    'button[name="major-blue"]': 'blueButtons'

    '.footer .progress .subject li': 'subjectProgressBullets'
    '.footer .progress .series .fill': 'seriesProgressFill'

    '.reveal .storm': 'storm'

    'button[name="pro-classify"]': 'proClassifyButton'
    'button[name="continue"]': 'continueButton'
    'button[name="next-subject"]': 'nextButton'

  map: null
  labels: null # Labelled points on the map

  defaultImageSrc: ''

  previousSubject: null

  nextSetup: null

  constructor: ->
    super

    @el.attr tabindex: 0 # Make this focusable.

    @map ?= new Map
      apiKey: '21a5504123984624a5e1a856fc00e238'
      latitude: 33
      longitude: -60
      zoom: 5

    @map.el.prependTo @el.parent() # Is it a little sloppy to modify outside nodes?

    @labels ?= []

    @defaultImageSrc = @matchImage.attr 'src'
    @nextSubjects()

  nextSubjects: =>
    @previousSubject = TEST.selection[0]
    TEST.selection.splice 0
    TEST.selection.push TEST.subjects.splice(0, 1)...

    if TEST.selection.length > 0
      @onChangeSubjects TEST.selection
    else
      alert 'No more subjects!'

  onChangeSubjects: (subjects) =>
    @classification = new Classification
    @classification.onChange @render
    @render()

    if subjects[0].metadata.index is 0
      # First subject in a set, so clear out old labels.
      @map.removeLabel label for label in @labels
      @labels.splice 0
      @seriesProgressFill.css width: 0

    @labels.push @map.addLabel subjects[0].coords..., subjects[0].coords.join ', '
    @map.setCenter subjects[0].coords..., center: [0.25, 0.5]

    @previousImage.attr src: @previousSubject?.location.standard
    @subjectImage.attr src: subjects[0].location.standard

    meta = subjects[0].metadata
    @storm.html "#{meta.type} #{meta.name} (#{meta.year})"

    if @previousSubject?
      @setupStronger()
    else
      @setupCatsAndMatches()

  render: (attribute, value) =>
    if attribute
      @["render#{attribute.charAt(0).toUpperCase() + attribute[1...]}"]? value
    else
      method() for name, method of @ when name.match /^render.+/

    @activateButtons()

  activateButtons: =>
    for button in @el.find '[data-requires-selection]'
      $(button).prop disabled: not @classification.get(@el.attr 'data-step')?

  setupStronger: =>
    console.log 'Setup stronger'
    @previousImage.css height: @subjectImage.height(), left: @subjectImage.css('left'), width: @subjectImage.width()
    @subjectImage.css left: OFF_RIGHT
    @matchImage.animate opacity: 0, =>
      @subjectImage.animate height: NORMAL_SIZE, left: NORMAL_RIGHT, width: NORMAL_SIZE
      @previousImage.animate height: NORMAL_SIZE, left: NORMAL_LEFT, width: NORMAL_SIZE
      @subjectImage.parent().animate height: NORMAL_SIZE

    @el.attr 'data-step': 'stronger'
    @nextSetup = @setupCatsAndMatches
    @activateButtons()

  renderStronger: (stronger) =>
    @strongerButtons.removeClass 'selected'

    if stronger?
      @strongerButtons.filter("[value='#{stronger}']").addClass 'selected'

  setupCatsAndMatches: =>
    @previousImage.animate left: OFF_LEFT, =>
      @subjectImage.animate left: NORMAL_LEFT
      @matchImage.css left: OFF_RIGHT, opacity: 1
      @matchImage.animate left: NORMAL_RIGHT
    @el.attr 'data-step': 'match'
    @nextSetup = null
    @activateButtons()

  renderCategory: (category) =>
    @categoryButtons.removeClass 'selected'
    @matchLists.removeClass 'selected'
    @subjectProgressBullets.eq(1).toggleClass 'filled', category?

    if category?
      @categoryButtons.filter("[value='#{category}']").addClass 'selected'
      matchList = @matchLists.filter "[data-category='#{category}']"
      matchList.addClass 'selected'
      naturalHeight = matchList.outerHeight()
      @matchListsContainer.css height: '0px'
      setTimeout (=> @matchListsContainer.css height: naturalHeight), 0
    else
      @matchListsContainer.css height: '0px'

    @classification.annotate match: null

  renderMatch: (match) =>
    @matchImage.toggleClass 'selected', match?
    @matchButtons.removeClass 'selected'
    @subjectProgressBullets.eq(2).toggleClass 'filled', match?

    if match?
      @matchButtons.filter("[value='#{match}']").addClass 'selected'

      # TODO: Do this better.
      @matchImage.attr src: @matchButtons.filter(".selected").find('img').attr 'src'
    else
      @matchImage.attr src: @defaultImageSrc

  setupCenter: =>
    @subjectImage.animate height: PRO_SIZE, left: PRO_LEFT, width: PRO_SIZE
    @subjectImage.parent().animate height: PRO_SIZE
    @matchImage.animate left: PRO_RIGHT, opacity: 0

    @el.attr 'data-step': 'center'
    @nextSetup = switch @classification.get 'category'
      when 'eye' then @setupSurrounding
      when 'embedded' then @setupFeature
      when 'curved' then @setupBlue
      when 'shear' then @setupRed

    @activateButtons()

  renderCenter: (coords) =>
    # Draw a spot.

  setupSurrounding: =>
    @el.attr 'data-step': 'surrounding'
    @nextSetup = @setupExceeding
    @activateButtons()

  renderSurrounding: (surrounding) =>
    @surroundingButtons.removeClass 'selected'

    if surrounding?
      @surroundingButtons.filter("[value='#{surrounding}']").addClass 'selected'

  setupExceeding: =>
    @el.attr 'data-step': 'exceeding'
    @nextSetup = @setupFeature
    @activateButtons()

  renderExceeding: (exceeding) =>
    @exceedingButtons.removeClass 'selected'

    if exceeding?
      @exceedingButtons.filter("[value='#{exceeding}']").addClass 'selected'

  setupFeature: =>
    @el.attr 'data-step': 'feature'
    @nextSetup = null
    @activateButtons()

  renderFeature: (feature) =>
    @featureButtons.removeClass 'selected'
    if feature?
      @featureButtons.filter("[value='#{feature}']").addClass 'selected'

  setupBlue: =>
    @el.attr 'data-step': 'blue'
    @activateButtons()

  renderBlue: =>
    @blueButtons.removeClass 'selected'
    if blue?
      @blueButtons.filter("[value='#{blue}']").addClass 'selected'

  setupRed: =>
    @el.attr 'data-step': 'red'
    @activateButtons()

  renderRed: =>
    # Draw a spot.

  onClickSubject: (e) =>
    # TODO: Where'd they click?
    [x, y] = [0.5, 0.5]

    params = {}
    params[@el.attr 'data-step'] = [x, y]
    @classification.annotate params

  onClickButton: ({currentTarget}) =>
    target = $(currentTarget)
    property = target.attr 'name'
    value = target.val()
    value = true if value is 'true'
    value = false if value is 'false'

    annotation = {}

    annotation[property] = value
    annotation[property] = null if value is @classification.get property

    @classification.annotate annotation

  setupReveal: =>
    @el.attr 'data-step': 'reveal'
    @classification.annotate reveal: true # For the "next" button
    @activateButtons()

  onClickProClassify: =>
    @setupCenter()

  onClickContinue: (e) =>
    @nextSetup?()

  onClickNext: =>
    console.info 'Classified', JSON.stringify @classification.values
    # Subject last in set and not revealed? Reveal.
    @nextSubjects()

module.exports = Classifier
