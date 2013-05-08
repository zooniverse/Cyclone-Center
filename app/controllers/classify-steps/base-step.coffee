Controller = require 'zooniverse/controllers/base-controller'
SVG = require '../../lib/svg'
$ = require 'jqueryify'

nextId = 0

class BaseStep
  classifier: null

  template: null
  controls: null

  hasDrawing: false
  svg: null

  property: ''

  events: null
  elements: null

  el: null

  constructor: (params = {}) ->
    @[property] = value for property, value of params
    @el = @classifier.el

    if @template?
      @controls = $(@template @)
      @controls.appendTo @classifier.stepControls
      @controls.hide()

    SUBJECT_WIDTH = 318
    SUBJECT_HEIGHT = 318

    if @hasDrawing
      @svg = new SVG width: 100, height: 100
      @svg.el.style.display = 'none'
      @svg.el.style.position = 'absolute'
      @svg.el.style.left = 0
      @svg.el.style.top = 0
      @svg.el.style.width = SUBJECT_WIDTH
      @svg.el.style.height = SUBJECT_HEIGHT
      @svg.el.style.left = '50%'
      @svg.el.style.top = '50%'
      @svg.el.style.marginLeft = -0.5 * SUBJECT_WIDTH
      @svg.el.style.marginTop = -0.5 * SUBJECT_HEIGHT
      @classifier.el.find('.subject').append @svg.el

    setTimeout =>
      Controller::nameElements.call @

  enter: ->
    @controls.show()
    @svg?.el.style.display = ''
    Controller::delegateEvents.call @

  leave: ->
    @controls.hide()
    @svg?.el.style.display = 'none'
    @el.off ".#{@id}"

module.exports = BaseStep
