Spine = require 'spine'
config = require '../lib/config'
CycloneSubject = require '../models/cyclone_subject'
Map = require 'zooniverse/lib/map'
Dialog = require 'zooniverse/lib/dialog'
Classification = require '../models/classification'
Favorite = require 'zooniverse/lib/models/favorite'
StatsDialog = require './stats_dialog'

class Classifier extends Spine.Controller
  events:
    'mousedown .main-pair .subject': 'onMouseDownSubject'

    'click button[name="stronger"]': 'onClickButton'
    'click button[name="category"]': 'onClickButton'
    'click button[name="match"]': 'onClickButton'
    'click button[name="eye"]': 'onClickButton'
    'click button[name="surrounding"]': 'onClickButton'
    'click button[name="exceeding"]': 'onClickButton'
    'click button[name="feature"]': 'onClickButton'
    'click button[name="blue"]': 'onClickButton'
    'click button[name="curve"]': 'onClickButton'

    'click button[name="restart"]': 'onClickRestart'
    'change input[name="detailed"]': 'onChangeDetailed'
    'click button[name="continue"]': 'onClickContinue'
    'click button[name="next-subject"]': 'onClickNext'
    'click button[name="next-storm"]': 'onClickNext'

    'click button[name="view-stats"]': 'onClickViewStats'
    'click button[name="favorite"]': 'onClickFavorite'
    'click button[name="unfavorite"]': 'onClickUnfavorite'

  elements:
    '.main-pair .previous': 'previousImage'
    '.main-pair .subject': 'subjectImage'
    '.main-pair .match': 'matchImage'
    '.center.point': 'centerPoint'
    '.eye.circle': 'eyeCircle'
    '.red.point': 'redPoint'
    '.calipers': 'calipers'

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
    'button[name="view-stats"]': 'statsButton'
    'button[name="next-subject"]': 'nextButton'
    'button[name="next-storm"]': 'nextStormButton'

  map: null
  labels: null # Labelled points on the map

  defaultImageSrc: ''

  recentClassifications = null

  nextSetup: null

  constructor: ->
    super

    @el.attr tabindex: 0 # Make this focusable.

    @detailedCheckbox.prop checked: localStorage.detailedClassification

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
    CycloneSubject.next @onChangeSubjects

  onChangeSubjects: (subject) =>
    return unless CycloneSubject.current
    @classification = new Classification subject: CycloneSubject.current
    @classification.onChange @render
    @render()

    availableSubjects = CycloneSubject.count()

    if availableSubjects is config.setSize
      # We won't use any previous subject.
      @recentClassifications.splice()

      # This is the first subject in a set, so clear out old labels.
      @map.removeLabel label for label in @labels
      @labels.splice 0

    @labels.push @map.addLabel subject.coords..., subject.coords.join ', '
    setTimeout => @map.setCenter subject.coords..., center: [0.25, 0.5]

    @previousImage.attr src: subject.location.yesterday
    @subjectImage.attr src: subject.location.standard

    index = config.setSize - availableSubjects
    remaining = availableSubjects - 1
    @progressMessage.html "#{CycloneSubject.count()} more to go..."
    @seriesProgressFill.css width: "#{index / (remaining + index + 1) * 100}%"

    meta = subject.metadata
    @revealStorm.html "#{meta.name} (#{meta.year})"

    if CycloneSubject.current.location.yesterday
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
    step = @el.attr 'data-step'

    @continueButton.toggle @nextSetup?
    @statsButton.toggle step is 'reveal'
    @nextButton.toggle not @nextSetup? and step isnt 'reveal'
    @nextStormButton.toggle step is 'reveal'

    @continueButton.add(@nextButton).prop
      disabled: not @classification.get(@el.attr 'data-step')?

    # http://zol.tumblr.com/post/461878753/safari-css-attribute-selector-bug
    $('body').toggleClass 'safari-css-hack'

  setupStronger: =>
    @el.attr 'data-step': 'stronger'
    @nextSetup = @setupCatsAndMatches
    @activateButtons()

  renderStronger: (stronger) =>
    @strongerButtons.removeClass 'selected'

    if stronger?
      @strongerButtons.filter("[value='#{stronger}']").addClass 'selected'

  setupCatsAndMatches: =>
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

    setTimeout => @classification.annotate 'match', null

  renderMatch: (match) =>
    @matchImage.toggleClass 'selected', match?
    @matchButtons.removeClass 'selected'

    if match?
      @matchButtons.filter("[value='#{match}']").addClass 'selected'

      # TODO: Do this better.
      @matchImage.attr src: @matchButtons.filter(".selected").find('img').attr('src').replace '.thumb', ''
    else
      @matchImage.attr src: @defaultImageSrc

  startDetailedClassify: =>
    if @classification.get('category') is 'eye'
      @setupEye()
    else
      @setupCenter()

  setupCenter: =>
    @el.attr 'data-step': 'center'
    @nextSetup = switch @classification.get 'category'
      when 'embedded' then @setupFeature
      when 'curved' then @setupBlue
      when 'shear' then @setupRed
      else null

    @activateButtons()

  renderCenter: (coords) =>
    if coords?
      imgOffset = @subjectImage.offset()
      parentOffset = @subjectImage.parent().offset()
      x = coords[0] * @subjectImage.width() + (imgOffset.left - parentOffset.left)
      y = coords[1] * @subjectImage.height() + (imgOffset.top - parentOffset.top)
      @centerPoint.css left: x, top: y
      @eyeCircle.css left: x, top: y
    else
      @centerPoint.css left: "-50%", top: "-50%" # Hide it.
      @eyeCircle.css left: "-50%", top: "-50%" # Hide it.

  setupEye: =>
    @el.attr 'data-step': 'eye'
    @nextSetup = @setupSurrounding
    @activateButtons()

  renderEye: (size) =>
    @eyeCircle.toggle size?
    @eyeCircle.attr 'data-size': size

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

  renderCalipers: (coords) =>
    if coords?
      imgOffset = @subjectImage.offset()
      parentOffset = @subjectImage.parent().offset()
      x = coords[0] * @subjectImage.width() + (imgOffset.left - parentOffset.left)
      y = coords[1] * @subjectImage.height() + (imgOffset.top - parentOffset.top)
      @calipers.css left: x, top: y
    else
      @calipers.css left: "-50%", top: "-50%"

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
      toSelect = @blueButtons.filter "[value='#{blue}']"
      toSelect.prevAll().andSelf().addClass 'selected'

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
    return unless step in ['center', 'eye', 'exceeding', 'red']

    e.preventDefault()
    offset = @subjectImage.offset()
    x = Math.min Math.max((e.pageX - offset.left) / @subjectImage.width(), 0), 1
    y = Math.min Math.max((e.pageY - offset.top) / @subjectImage.height(), 0), 1

    step = 'center' if step is 'eye'
    step = 'calipers' if step is 'exceeding'
    @classification.annotate step, [x, y]

  onMouseUpDocument: =>
    delete @mouseDown

  onClickButton: ({currentTarget}) =>
    target = $(currentTarget)

    property = target.attr 'name'

    value = target.val()
    value = true if value is 'true'
    value = false if value is 'false'
    value = null if value is @classification.get property

    @classification.annotate property, value

  setupReveal: =>
    @progressMessage.html ""

    @revealList.empty()
    for classification in @recentClassifications
      item = @revealTemplate.clone()
      item.attr 'data-subject': classification.subject.id
      item.find('img').attr src: classification.subject.location.standard
      item.find('a.talk').attr href: classification.subject.talkHref()
      item.appendTo @revealList

    @el.attr 'data-step': 'reveal'
    @seriesProgressFill.css width: '100%'
    @classification.annotate 'reveal', true # For the "next" button
    @nextSetup = null
    @activateButtons()

  onClickFavorite: ({currentTarget}) =>
    itemParent = $(currentTarget).parents '[data-subject]'
    subjectId = itemParent.attr 'data-subject'

    favorite = Favorite.create({})
    favorite.subjects = {id: subjectId}
    favorite.save()

    send = favorite.send().deferred
    @el.addClass 'favoriting'
    send.done ->
      # Give the the favorite a chance to update its ID.
      setTimeout ->
        itemParent.removeClass 'favoriting'
        itemParent.attr 'data-favorite': favorite.id

  onClickUnfavorite: ({currentTarget}) =>
    itemParent = $(currentTarget).parents '[data-favorite]'
    favoriteId = itemParent.attr 'data-favorite'

    favorite = Favorite.find favoriteId

    destroy = favorite.destroy().deferred
    destroy.done ->
      itemParent.attr 'data-favorite': null

  onClickViewStats: =>
    console.log 'Viewing stats for', @recentClassifications[0].subject.groupId
    new StatsDialog
      stormId: @recentClassifications[0].subject.groupId
      destroyOnClose: true

  onClickRestart: (e) =>
    for property of @classification.annotations
      @classification.annotate property, null

    if CycloneSubject.current.location.yesterday
      @setupStronger()
    else
      @setupCatsAndMatches()

  onChangeDetailed: (e) =>
    advanced = @detailedCheckbox.get(0).checked
    localStorage.detailedClassification = advanced || ''

    @el.toggleClass 'advanced', !!advanced

    if @el.attr('data-step') in ['category', 'match']
      @nextSetup = if advanced
        @startDetailedClassify
      else
        null

      @activateButtons()

  onClickContinue: (e) =>
    @nextSetup()

  onClickNext: =>
    @recentClassifications.push @classification
    @classification.send =>
      console.info 'Classified', JSON.stringify @classification.toJSON()

    if CycloneSubject.count() is 1 and not @classification.get 'reveal'
      @setupReveal()
    else
      @nextSubjects()

module.exports = Classifier
