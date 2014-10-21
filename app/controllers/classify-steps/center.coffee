Step = require './base-step'
translate = require 't7e'
$ = window.jQuery

class Center extends Step
  property: ['center']

  template: require '../../views/classify-steps/center'
  explanation: translate 'div', 'classify.steps.center.explanation'

  hasDrawing: true
  crosshairs: null

  mouseIsDown: false

  events:
    'mousedown .subject': 'onMouseDownSubject'
    'mousemove .subject': 'onMouseMoveSubject'

  elements:
    'button[name="category"]': 'categoryButtons'
    '[data-category]': 'categoryLists'
    'button[name="match"]': 'matchButtons'

  enter: ->
    super
    @crosshairs ?= @svg.create 'path',
      d: 'M 0, -400 L 0, 400 M -400, 0 L 400, 0'
      stroke: 'black'
      'stroke-width': 2

    $(document).on "mouseup.#{@id}", @onDocumentMouseUp

    for section in @details.find 'section'
      section = $(section)
      section.toggle section.hasClass "for-#{@classifier.classification.get 'type'}"

  reset: ->
    super
    @crosshairs?.remove()
    @crosshairs = null

  onMouseDownSubject: (e) ->
    e.preventDefault()

    @mouseIsDown = true
    @onMouseMoveSubject e

  onMouseMoveSubject: (e) ->
    return unless @mouseIsDown

    subjectOffset = @classifier.currentImg.offset()

    # TODO: This seems a bit unreliable. Clean it up.

    subjectOffset = @classifier.currentImg.offset()
    x = e.pageX - subjectOffset.left
    y = e.pageY - subjectOffset.top

    @crosshairs.attr 'transform', "translate(#{x}, #{y})"

    @classifier.classification.set @property[0],
      x: x / @classifier.currentImg.width()
      y: y / @classifier.currentImg.height()

  onDocumentMouseUp: (e) =>
    return unless @mouseIsDown
    @mouseIsDown = false

  leave: ->
    super
    $(document).off "mouseup.#{@id}", @onDocumentMouseUp

module.exports = Center
