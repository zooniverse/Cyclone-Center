Step = require './base-step'
template = require '../../views/classify-steps/center'
SVG = require '../../lib/svg'
$ = require 'jqueryify'

class Center extends Step
  property: 'center'

  template: template

  svg: null
  circle: null

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
    window.centerStep = @

    @svg = new SVG width: 100, height: 100
    @svg.el.style.display = 'none'
    @svg.el.style.position = 'absolute'
    @svg.el.style.left = 0
    @svg.el.style.top = 0
    @svg.el.style.width = '100%'
    @svg.el.style.height = '100%'
    @classifier.el.find('.subject').append @svg.el

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

    x = (e.pageX - subjectOffset.left) + subjectImg.offsetLeft
    y = (e.pageY - subjectOffset.top) + subjectImg.offsetTop

    @circle.attr 'cx', x
    @circle.attr 'cy', y

    @classifier.classification.set 'center', {x, y}

  onDocumentMouseUp: (e) =>
    return unless @mouseIsDown
    @mouseIsDown = false

  enter: ->
    super
    $(document).on "mouseup.#{@id}", @onDocumentMouseUp
    @svg.el.style.display = ''

  leave: ->
    super
    $(document).off "mouseup.#{@id}", @onDocumentMouseUp
    @svg.el.style.display = 'none'

module.exports = Center
