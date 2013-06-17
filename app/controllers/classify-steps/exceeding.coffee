Step = require './base-step'
template = require '../../views/classify-steps/exceeding'
translate = require 't7e'
$ = window.jQuery

OLD_HALF_DEGREE_PROPORTION = 17.3 / 485
NEW_IMAGE_SIZE = 314
HALF_DEGREE = OLD_HALF_DEGREE_PROPORTION * NEW_IMAGE_SIZE
BOX_SPACING = 5
BOX_WIDTH = 2

class Exceeding extends Step
  property: 'coldest_at_least_0_5_deg'

  template: template
  explanation: translate 'div', 'classify.details.exceeding'

  hasDrawing: true
  center: null
  line: null

  events:
    'mousemove .subject': 'onMouseMove'
    'click button[name="exceeding"]': 'onClickExceeding'

  elements:
    'button[name="exceeding"]': 'buttons'

  constructor: ->
    super

    @center = @svg.create 'circle', r: 5, fill: 'black', 'stroke-width': 0

    @line = @svg.create 'path', d: """
      M -#{HALF_DEGREE + BOX_SPACING} -#{BOX_WIDTH}
      L -#{BOX_SPACING} -#{BOX_WIDTH}
      L -#{BOX_SPACING} #{BOX_WIDTH}
      L -#{HALF_DEGREE + BOX_SPACING} #{BOX_WIDTH}
      Z
    """, fill: 'transparent', stroke: 'black', 'stroke-width': 2

  enter: ->
    super

    center = @classifier.classification.get 'center'
    center ?= x: 0.5, y: 0.5
    x = center.x * @classifier.currentImg.width()
    y = center.y * @classifier.currentImg.height()

    @center.attr 'cx', x
    @center.attr 'cy', y

  reset: ->
    super
    @buttons.removeClass 'active'

  onMouseMove: (e) ->
    center = @classifier.classification.get 'center'
    center ?= x: 0.5, y: 0.5
    cx = center.x * @classifier.currentImg.width()
    cy = center.y * @classifier.currentImg.height()

    subjectOffset = @classifier.currentImg.offset()
    sx = e.pageX - subjectOffset.left
    sy = e.pageY - subjectOffset.top

    deltaX = cx - sx
    deltaY = cy - sy
    angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI

    @line.attr 'transform', "translate(#{sx} #{sy}) rotate(#{angle})"

  onClickExceeding: (e) ->
    target = $(e.currentTarget)

    @buttons.removeClass 'active'
    target.prevAll().andSelf().addClass 'active'

    @classifier.classification.set @property, parseFloat target.val()

module.exports = Exceeding
