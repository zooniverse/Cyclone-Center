Spine = require 'spine'
config = require '../lib/config'
CycloneSubject = require '../models/cyclone_subject'
Map = require 'zooniverse/lib/map'
Dialog = require 'zooniverse/lib/dialog'
StatsDialog = require './stats_dialog'

# Only temporary!
class Classification
  constructor: ({@subject}) ->
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

# Sizes for use in animations
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
    'mousedown .main-pair .subject': 'onMouseDownSubject'

    'click button[name="stronger"]': 'onClickButton'
    'click button[name="category"]': 'onClickButton'
    'click button[name="match"]': 'onClickButton'
    'click button[name="surrounding"]': 'onClickButton'
    'click button[name="exceeding"]': 'onClickButton'
    'click button[name="feature"]': 'onClickButton'
    'click button[name="blue"]': 'onClickButton'
    'click button[name="curve"]': 'onClickButton'

    'click button[name="restart"]': 'onClickRestart'
    'change input[name="detailed"]': 'onChangeDetailed'
    'click button[name="continue"]': 'onClickContinue'
    'click button[name="next-subject"]': 'onClickNext'

  elements:
    '.main-pair .previous': 'previousImage'
    '.main-pair .subject': 'subjectImage'
    '.main-pair .match': 'matchImage'
    '.center.point': 'centerPoint'
    '.eye.point': 'eyePoint'
    '.red.point': 'redPoint'

    'button[name="stronger"]': 'strongerButtons'
    'button[name="category"]': 'categoryButtons'
    '.matches': 'matchListsContainer'
    '.matches > ul': 'matchLists'
    'button[name="match"]': 'matchButtons'
    'button[name="surrounding"]': 'surroundingButtons'
    'button[name="exceeding"]': 'exceedingButtons'
    'button[name="feature"]': 'featureButtons'
    'button[name="blue"]': 'blueButtons'
    'button[name="curve"]': 'curveButtons'

    '.footer .progress .message': 'progressMessage'
    '.footer .progress .series .fill': 'seriesProgressFill'

    '.reveal .storm': 'revealStorm'
    '.reveal ul': 'revealList'
    '.reveal [data-subject="TEMPLATE"]': 'revealTemplate'

    'input[name="detailed"]': 'detailedCheckbox'
    'button[name="continue"]': 'continueButton'
    'button[name="next-subject"]': 'nextButton'

  map: null
  labels: null # Labelled points on the map

  defaultImageSrc: ''

  previousSubject: null
  recentClassifications = null

  nextSetup: null

  constructor: ->
    super

    @el.attr tabindex: 0 # Make this focusable.

    @map ?= new Map
      latitude: 33
      longitude: -60
      zoom: 5
      className: 'full-screen'

    @map.el.prependTo @el.parent() # Is it a little sloppy to modify outside nodes?

    @labels ?= []
    @recentClassifications = []

    @defaultImageSrc = @matchImage.attr 'src'
    @nextSubjects()

    @revealTemplate.remove()

    doc = $(document)
    doc.on 'mousemove', @onMouseMoveDocument
    doc.on 'mouseup', @onMouseUpDocument

  nextSubjects: =>
    @previousSubject = CycloneSubject.current
    CycloneSubject.next @onChangeSubjects

  onChangeSubjects: (subject) =>
    @classification = new Classification subject: CycloneSubject.current
    @classification.onChange @render
    @render()

    availableSubjects = CycloneSubject.count()

    if availableSubjects is config.setSize
      # We won't use any previous subject.
      @previousSubject = null
      @recentClassifications.splice()

      # This is the first subject in a set, so clear out old labels.
      @map.removeLabel label for label in @labels
      @labels.splice 0

    @labels.push @map.addLabel subject.coords..., subject.coords.join ', '
    setTimeout => @map.setCenter subject.coords..., center: [0.25, 0.5]

    @previousImage.attr src: @previousSubject?.location.standard
    @subjectImage.attr src: subject.location.standard

    index = config.setSize - availableSubjects
    remaining = availableSubjects - 1
    @progressMessage.html "#{CycloneSubject.count()} more to go..."
    @seriesProgressFill.css width: "#{index / (remaining + index + 1) * 100}%"

    meta = subject.metadata
    @revealStorm.html "#{meta.type} #{meta.name} (#{meta.year})"

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
    @continueButton.toggle @nextSetup?
    @nextButton.toggle not @nextSetup?

    @continueButton.add(@nextButton).prop
      disabled: not @classification.get(@el.attr 'data-step')?

    # http://zol.tumblr.com/post/461878753/safari-css-attribute-selector-bug
    $('body').toggleClass 'safari-css-hack'

  setupStronger: =>
    @previousImage.css height: @subjectImage.height(), left: @subjectImage.css('left'), width: @subjectImage.width()
    @subjectImage.css left: OFF_RIGHT
    @matchImage.animate opacity: 0, =>
      @subjectImage.parent().animate height: NORMAL_SIZE
      @previousImage.animate height: NORMAL_SIZE, left: NORMAL_LEFT, width: NORMAL_SIZE
      @subjectImage.animate height: NORMAL_SIZE, left: NORMAL_RIGHT, width: NORMAL_SIZE

    @el.attr 'data-step': 'stronger'
    @nextSetup = @setupCatsAndMatches
    @activateButtons()

  renderStronger: (stronger) =>
    @strongerButtons.removeClass 'selected'

    if stronger?
      @strongerButtons.filter("[value='#{stronger}']").addClass 'selected'

  setupCatsAndMatches: =>
    @previousImage.animate left: OFF_LEFT, =>
      @subjectImage.parent().animate height: NORMAL_SIZE
      @subjectImage.animate height: NORMAL_SIZE, left: NORMAL_LEFT, width: NORMAL_SIZE
      @matchImage.css left: OFF_RIGHT, opacity: 1
      @matchImage.animate left: NORMAL_RIGHT

    @el.attr 'data-step': 'match'

    @nextSetup = @setupCenter

    @onChangeDetailed()

  renderCategory: (category) =>
    @categoryButtons.removeClass 'selected'
    @matchLists.removeClass 'selected'

    if category?
      @categoryButtons.filter("[value='#{category}']").addClass 'selected'

      matchList = @matchLists.filter "[data-category='#{category}']"
      matchList.addClass 'selected'

      oldHeight = @matchListsContainer.height()
      @matchListsContainer.css height: ''
      naturalHeight = @matchListsContainer.height()

      @matchListsContainer.css height: oldHeight
      @matchListsContainer.animate height: naturalHeight
    else
      @matchListsContainer.animate height: 0, =>

    setTimeout => @classification.annotate match: null

  renderMatch: (match) =>
    @matchImage.toggleClass 'selected', match?
    @matchButtons.removeClass 'selected'

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
      when 'eye' then @setupEye
      when 'embedded' then @setupFeature
      when 'curved' then @setupBlue
      when 'shear' then @setupRed

    @activateButtons()

  renderCenter: (coords) =>
    if coords?
      imgOffset = @subjectImage.offset()
      parentOffset = @subjectImage.parent().offset()
      x = coords[0] * @subjectImage.width() + (imgOffset.left - parentOffset.left)
      y = coords[1] * @subjectImage.height() + (imgOffset.top - parentOffset.top)
      @centerPoint.css left: x, top: y
    else
      @centerPoint.css left: "-50%", top: "-50%" # Hide it.

  setupEye: =>
    @el.attr 'data-step': 'eye'
    @nextSetup = @setupSurrounding
    @activateButtons()

  renderEye: (coords) =>
    if coords?
      imgOffset = @subjectImage.offset()
      parentOffset = @subjectImage.parent().offset()
      x = coords[0] * @subjectImage.width() + (imgOffset.left - parentOffset.left)
      y = coords[1] * @subjectImage.height() + (imgOffset.top - parentOffset.top)
      @eyePoint.css left: x, top: y
    else
      @eyePoint.css left: "-50%", top: "-50%"

  setupSurrounding: =>
    @el.attr 'data-step': 'surrounding'
    @nextSetup = @setupExceeding
    @activateButtons()

  renderSurrounding: (surrounding) =>
    @surroundingButtons.removeClass 'selected'

    if surrounding?
      toSelect = @surroundingButtons.filter "[value='#{surrounding}']"
      toSelect.prevAll().andSelf().addClass 'selected'

  setupExceeding: =>
    @el.attr 'data-step': 'exceeding'
    @nextSetup = @setupFeature
    @activateButtons()

  renderExceeding: (exceeding) =>
    @exceedingButtons.removeClass 'selected'

    if exceeding?
      toSelect = @exceedingButtons.filter "[value='#{exceeding}']"
      toSelect.prevAll().andSelf().addClass 'selected'

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
    @nextSetup = @setupCurve
    @activateButtons()

  renderBlue: (blue) =>
    @blueButtons.removeClass 'selected'
    if blue?
      @blueButtons.filter("[value='#{blue}']").addClass 'selected'

  setupCurve: =>
    @el.attr 'data-step': 'curve'
    @nextSetup = null
    @activateButtons()

  renderCurve: (curve) =>
    @curveButtons.removeClass 'selected'
    if curve?
      @curveButtons.filter("[value='#{curve}']").addClass 'selected'

  setupRed: =>
    @el.attr 'data-step': 'red'
    @nextSetup = null
    @activateButtons()

  renderRed: (coords) =>
    if coords?
      imgOffset = @subjectImage.offset()
      parentOffset = @subjectImage.parent().offset()
      x = coords[0] * @subjectImage.width() + (imgOffset.left - parentOffset.left)
      y = coords[1] * @subjectImage.height() + (imgOffset.top - parentOffset.top)
      @redPoint.css left: x, top: y
    else
      @redPoint.css left: "-50%", top: "-50%"

  onMouseDownSubject: (e) =>
    @mouseDown = e
    @onDragSubject e

  onMouseMoveDocument: (e) =>
    @onDragSubject e if @mouseDown

  onDragSubject: (e) =>
    step = @el.attr 'data-step'
    return unless step in ['center', 'eye', 'red']

    e.preventDefault()
    offset = @subjectImage.offset()
    x = Math.min Math.max((e.pageX - offset.left) / @subjectImage.width(), 0), 1
    y = Math.min Math.max((e.pageY - offset.top) / @subjectImage.height(), 0), 1

    annotation = {}
    annotation[step] = [x, y]
    @classification.annotate annotation

  onMouseUpDocument: =>
    delete @mouseDown

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
    console.info 'Revealing', @recentClassifications

    @revealList.empty()
    for classification in @recentClassifications
      item = @revealTemplate.clone()
      item.attr 'data-subject': classification.subject.id
      item.find('img').attr src: classification.subject.location.standard
      item.find('.date').html classification.subject.metadata.captured.toString().split(' ')[1..4].join ' '
      item.find('.lat').html classification.subject.coords[0]
      item.find('.lng').html classification.subject.coords[1]
      item.appendTo @revealList

    @el.attr 'data-step': 'reveal'
    @seriesProgressFill.css width: '100%'
    @classification.annotate reveal: true # For the "next" button
    @activateButtons()

  onClickRestart: (e) =>
    for property of @classification.values
      clear = {}
      clear[property] = null
      @classification.annotate clear

    if @previousSubject
      @setupStronger()
    else
      @setupCatsAndMatches()

  onChangeDetailed: (e) =>
    advanced = @detailedCheckbox.get(0).checked
    @el.toggleClass 'advanced', !!advanced

    if @el.attr('data-step') in ['category', 'match']
      @nextSetup = if advanced
        @setupCenter
      else
        null

      @activateButtons()

  onClickContinue: (e) =>
    @nextSetup()

  onClickNext: =>
    console.info 'Classified', JSON.stringify @classification.values
    @recentClassifications.push @classification

    if CycloneSubject.count() is 1 and not @classification.get 'reveal'
      @setupReveal()
    else
      @nextSubjects()

module.exports = Classifier
