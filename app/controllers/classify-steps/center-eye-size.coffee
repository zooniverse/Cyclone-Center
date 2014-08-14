CenterStep = require './center'
translate = require 't7e'
$ = window.jQuery

SHOWN_IMAGE_SIZE = 318
REAL_IMAGE_SIZE = 600

class CenterEyeSizeStep extends CenterStep
  property: ['center', 'eyewall']

  template: require '../../views/classify-steps/center-eye-size'
  explanation: translate 'div', 'classify.steps.centerEyeSize.explanation'

  circle: null

  events: ($.extend {}, CenterStep::events,
    'click button[name="eye"]': 'onClickEye'
  )

  elements: ($.extend {}, CenterStep::elements,
    'button[name="eye"]': 'buttons'
  )

  enter: ->
    super
    @circle ?= @svg.create 'circle',
      r: 0
      fill: 'transparent'
      stroke: 'black'
      'stroke-width': 2

  reset: ->
    super
    @circle?.remove()
    @circle = null

    @buttons.removeClass 'active'

  onMouseMoveSubject: ->
    super
    return unless @mouseIsDown

    {x, y} = @classifier.classification.get @property[0]
    x *= @classifier.currentImg.width()
    y *= @classifier.currentImg.height()
    @circle.attr 'cx', x
    @circle.attr 'cy', y

  onClickEye: (e) ->
    target = $(e.currentTarget)
    value = target.val()

    @buttons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set @property[1], value

    km = value
    scale = SHOWN_IMAGE_SIZE / REAL_IMAGE_SIZE
    deg = km / 111.12
    radius = (deg / 0.02337) * scale

    @circle.attr 'r', radius

module.exports = CenterEyeSizeStep
