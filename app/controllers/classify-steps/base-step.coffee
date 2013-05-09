Controller = require 'zooniverse/controllers/base-controller'
SVG = require '../../lib/svg'
$ = require 'jqueryify'

nextId = 0

class BaseStep
  classifier: null

  template: null
  controls: null

  explanation: null
  details: null

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
      @controls = $("<div>#{@template @}</div>")
      @controls.appendTo @classifier.stepControls
      @controls.hide()

    if @explanation?
      @details = $("<div>#{@explanation}</div>")
      @details.appendTo @classifier.detailsContainer
      @details.hide()

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

    Controller::nameElements.call @

  enter: ->
    @svg?.el.style.display = ''
    @controls?.show()
    @details?.show()
    Controller::delegateEvents.call @
    @reset()

  reset: ->
    # Do what you gotta do.

  leave: ->
    @svg?.el.style.display = 'none'
    @controls?.hide()
    @details?.hide()
    @el.off ".#{@id}"

module.exports = BaseStep
