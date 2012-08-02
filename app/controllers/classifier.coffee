Spine = require('spine')
Map = require('Zooniverse/lib/map')

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

  elements:
    '.main-pair .subject': 'subjectImage'
    '.main-pair .match': 'matchImage'
    'button[name="category"]': 'categoryButtons'
    '.matches': 'matchListsContainer'
    '.matches > ol': 'matchLists'
    '.footer .progress .subject li': 'subjectProgressBullets'
    'button[name="match"]': 'matchButtons'
    'button[name="choose"]': 'chooseButton'

  map: null
  defaultImageSrc: ''

  constructor: ->
    super

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
    @onChangeSubjects [location: standard: 'http://placehold.it/300.png']

  onChangeSubjects: (subjects) =>
    @el.removeClass 'post-classify'
    @el.removeClass 'is-favorited'
    @el.toggleClass 'can-favorite', true # User is signed in and subjects are not tutorial subjects
    @restart()

  restart: =>
    @selectCategory null
    @selectMatch null
    @subjectProgressBullets.removeClass 'filled'
    @subjectProgressBullets.eq(0).addClass 'filled'

  onClickCategory: ({target}) =>
    return if @el.hasClass 'post-classify'
    if $(target).hasClass 'selected'
      @selectCategory null
    else
      @selectCategory target.value

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

  onClickMatch: ({target}) =>
    return if @el.hasClass 'post-classify'
    if $(target).hasClass 'selected'
      @selectMatch null
    else
      @selectMatch target.value

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

module.exports = Classifier
