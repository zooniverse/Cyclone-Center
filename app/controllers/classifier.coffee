Spine = require('spine')
Map = require('Zooniverse/lib/map')

TEST =
  selection: []
  subjects: [
    {id: 0, group: 0, location: {standard: 'http://placehold.it/300/f00.png'}, coords: [24, -70], metadata: {index: 0}}
    {id: 1, group: 0, location: {standard: 'http://placehold.it/300/ff0.png'}, coords: [26, -70], metadata: {index: 1}}
    {id: 2, group: 1, location: {standard: 'http://placehold.it/300/0f0.png'}, coords: [28, -70], metadata: {index: 2}}
    {id: 3, group: 1, location: {standard: 'http://placehold.it/300/0ff.png'}, coords: [30, -70], metadata: {index: 3}}
    {id: 4, group: 2, location: {standard: 'http://placehold.it/300/00f.png'}, coords: [32, -70], metadata: {index: 4}}
    {id: 5, group: 2, location: {standard: 'http://placehold.it/300/f0f.png'}, coords: [34, -70], metadata: {index: 5}}
  ]

class Classifier extends Spine.Controller
  events:
    'click button[name="category"]': 'onClickCategory'
    'click button[name="match"]': 'onClickMatch'
    'click button[name="restart"]': 'restart'
    'click button[name="choose"]': 'choose'
    'click button[name="favorite"]': 'createFavorite'
    'click button[name="unfavorite"]': 'destroyFavorite'
    'click button[name="talk"]': 'goToTalk'
    'click button[name="next"]': 'nextSubjects'
    'keydown': 'onKeyDown'

  elements:
    '.main-pair .subject': 'subjectImage'
    '.main-pair .match': 'matchImage'
    'button[name="category"]': 'categoryButtons'
    '.matches': 'matchListsContainer'
    '.matches > ol': 'matchLists'
    '.footer .progress .subject li': 'subjectProgressBullets'
    'button[name="match"]': 'matchButtons'
    'button[name="choose"]': 'chooseButton'
    'button[name="next"]': 'nextButton'

  map: null
  defaultImageSrc: ''

  constructor: ->
    super

    @el.attr tabindex: 0

    @map ?= new Map
      apiKey: '21a5504123984624a5e1a856fc00e238'
      latitude: 33
      longitude: -60
      zoom: 5

    @map.el.prependTo @el.parent()
    @map.resize()

    @defaultImageSrc = @matchImage.attr 'src'
    @nextSubjects()

  nextSubjects: =>
    TEST.selection.splice 0
    TEST.selection.push TEST.subjects.splice(0, 1)...
    if TEST.selection.length > 0
      @onChangeSubjects TEST.selection
    else
      alert 'No more subjects!'
      setTimeout => @restart()

  onChangeSubjects: (subjects) =>
    @restart()
    @el.removeClass 'post-classify'
    @el.removeClass 'is-favorited'
    @el.toggleClass 'can-favorite', true # User is signed in and subjects are not tutorial subjects

    @map.addLabel subjects[0].coords..., subjects[0].coords.join ', '
    @subjectImage.attr src: subjects[0].location.standard

  restart: (subjects) =>
    @selectCategory null
    @selectMatch null
    @subjectProgressBullets.removeClass 'filled'
    @subjectProgressBullets.eq(0).addClass 'filled'

  onClickCategory: ({currentTarget}) =>
    return if @el.hasClass 'post-classify'
    if $(currentTarget).hasClass 'selected'
      @selectCategory null
    else
      @selectCategory currentTarget.value

  selectCategory: (category) =>
    @el.toggleClass 'during-classify', category?
    @categoryButtons.removeClass 'selected'
    @matchLists.removeClass 'selected'
    @subjectProgressBullets.eq(1).toggleClass 'filled', category?

    if category?
      @categoryButtons.filter("[value='#{category}']").addClass 'selected'
      matchList = @matchLists.filter "[data-category='#{category}']"
      matchList.addClass 'selected'
      naturalHeight = matchList.outerHeight()
      @matchListsContainer.css height: naturalHeight
    else
      @matchListsContainer.css height: '0px'

    @selectMatch null

  onClickMatch: ({currentTarget}) =>
    return if @el.hasClass 'post-classify'
    if $(currentTarget).hasClass 'selected'
      @selectMatch null
    else
      @selectMatch currentTarget.value

  selectMatch: (match) =>
    @matchImage.toggleClass 'selected', match?
    @matchButtons.removeClass 'selected'
    @subjectProgressBullets.eq(2).toggleClass 'filled', match?

    if match?
      @matchButtons.filter("[value='#{match}']").addClass 'selected'

      # TODO: Do this better.
      @matchImage.attr src: @matchButtons.filter(".selected").find('img').attr 'src'
    else
      @matchImage.attr src: @defaultImageSrc

    @chooseButton.attr disabled: not match?

  choose: =>
    @el.removeClass 'during-classify'
    @el.addClass 'post-classify'
    @subjectProgressBullets.eq(3).addClass 'filled'

  createFavorite: =>
    @el.addClass 'is-favorited'

  destroyFavorite: =>
    @el.removeClass 'is-favorited'

  goToTalk: =>
    # TODO

  keys: 49: 1, 50: 2, 51: 3, 52: 4, 53: 5, 13: 'ENTER', 27: 'ESCAPE'
  onKeyDown: ({which}) ->
    return unless which of @keys
    key = @keys[which]
    category = @categoryButtons.filter '.selected'
    matches = @matchLists.filter('.selected').find 'button'

    if key in [1..5]
      if category.length is 0
        @categoryButtons.eq(key - 1).click()
      else
        matches.eq(key - 1).click()

    if key is 'ENTER'
      if @el.hasClass 'post-classify'
        @nextButton.click()
      else
        @chooseButton.click()

    if key is 'ESCAPE'
      if matches.filter('.selected').length > 0
        @selectMatch null
      else if category.length > 0
        @selectCategory null

module.exports = Classifier
