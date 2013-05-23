Step = require './base-step'
template = require '../../views/classify-steps/red'
translate = require 't7e'
$ = window.jQuery

class Red extends Step
  property: 'red_point_nearest_center'

  template: template
  explanation: translate 'div', 'classify.details.red'

  hasDrawing: true
  center: null
  line: null

  mouseIsDown: false

  events:
    'mousedown .subject': 'onMouseDownSubject'
    'mousemove .subject': 'onMouseMoveSubject'

  elements:
    'button[name="category"]': 'categoryButtons'
    '[data-category]': 'categoryLists'
    'button[name="match"]': 'matchButtons'

  constructor: ->
    super

    @center = @svg.create 'circle', r: 5, fill: 'black', 'stroke-width': 0
    @line = @svg.create 'line', stroke: 'black', 'stroke-width': 3

  enter: ->
    super
    $(document).on "mouseup.#{@id}", @onDocumentMouseUp
    @svg.el.style.display = ''

    center = @classifier.classification.get 'center'
    red = @classifier.classification.get 'red'
    center ?= x: 160, y: 160
    red ?= center

    @center.attr 'cx', center.x
    @center.attr 'cy', center.y

    @line.attr 'x1', center.x
    @line.attr 'y1', center.y
    @line.attr 'x2', red.x
    @line.attr 'y2', red.y

  reset: ->
    super

  onMouseDownSubject: (e) ->
    e.preventDefault()

    @mouseIsDown = true
    @onMouseMoveSubject e

  onMouseMoveSubject: (e) ->
    return unless @mouseIsDown

    subjectOffset = @classifier.currentImg.offset()
    x = e.pageX - subjectOffset.left
    y = e.pageY - subjectOffset.top

    @line.attr 'x2', x
    @line.attr 'y2', y

    @classifier.classification.set 'red', {x, y}

  onDocumentMouseUp: (e) =>
    return unless @mouseIsDown
    @mouseIsDown = false

  leave: ->
    super
    $(document).off "mouseup.#{@id}", @onDocumentMouseUp
    @svg.el.style.display = 'none'

module.exports = Red
