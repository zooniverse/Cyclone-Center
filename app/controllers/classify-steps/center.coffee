Step = require './base-step'
template = require '../../views/classify-steps/center'
translate = require 't7e'
$ = window.jQuery

class Center extends Step
  property: 'center'

  template: template
  explanation: translate 'div', 'classify.details.center'

  hasDrawing: true
  circle: null

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
    $(document).on "mouseup.#{@id}", @onDocumentMouseUp
    @svg.el.style.display = ''

  reset: ->
    super
    @svg.el.removeChild @circle.el
    @circle = null

  onMouseDownSubject: (e) ->
    e.preventDefault()

    @circle ?= @svg.create 'circle',
      width: 10
      height: 10
      r: 10
      fill: 'transparent'
      stroke: 'black'
      'stroke-width': 3

    @mouseIsDown = true
    @onMouseMoveSubject e

  onMouseMoveSubject: (e) ->
    return unless @mouseIsDown

    subjectImg = @classifier.currentImg.get 0
    subjectOffset = @classifier.currentImg.offset()

    # TODO: This seems a bit unreliable. Clean it up.

    subjectOffset = @classifier.currentImg.offset()
    x = e.pageX - subjectOffset.left
    y = e.pageY - subjectOffset.top

    @circle.attr 'cx', x
    @circle.attr 'cy', y

    @classifier.classification.set 'center', {x, y}

  onDocumentMouseUp: (e) =>
    return unless @mouseIsDown
    @mouseIsDown = false

  leave: ->
    super
    $(document).off "mouseup.#{@id}", @onDocumentMouseUp
    @svg.el.style.display = 'none'

module.exports = Center
