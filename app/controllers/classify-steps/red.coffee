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

    w = @classifier.currentImg.width()
    h = @classifier.currentImg.height()

    center = @classifier.classification.get 'center'
    center ?= x: 0.5, y: 0.5

    cx = center.x * w
    cy = center.y * h

    @center.attr 'cx', cx
    @center.attr 'cy', cy

    @line.attr 'x1', cx
    @line.attr 'y1', cy

    red = @classifier.classification.get 'red'
    red ?= center

    rx = red.x * w
    ry = red.y * h

    @line.attr 'x2', rx
    @line.attr 'y2', ry

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

    @classifier.classification.set @property,
      x: x / @classifier.currentImg.width()
      y: y / @classifier.currentImg.height()

  onDocumentMouseUp: (e) =>
    return unless @mouseIsDown
    @mouseIsDown = false

  leave: ->
    super
    $(document).off "mouseup.#{@id}", @onDocumentMouseUp
    @svg.el.style.display = 'none'

module.exports = Red
