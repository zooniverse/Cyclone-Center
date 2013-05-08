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
      @svg.attr 'width', SUBJECT_WIDTH
      @svg.attr 'height', SUBJECT_HEIGHT
      @svg.attr 'style', """
        display: none;
        margin: #{-0.5 * SUBJECT_HEIGHT}px 0 0 #{-0.5 * SUBJECT_WIDTH}px;
        left: 50%;
        position: absolute;
        top: 50%;
      """
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
