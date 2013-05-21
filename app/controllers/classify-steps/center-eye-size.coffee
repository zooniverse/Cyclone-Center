CenterStep = require './center'
template = require '../../views/classify-steps/center-eye-size'
translate = require 't7e'
$ = window.jQuery

class CenterEyeSizeStep extends CenterStep
  property: ['center', 'size']

  template: template
  explanation: translate 'div', 'classify.details.centerEyeSize'

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

    {x, y} = @classifier.classification.get 'center'
    @circle.attr 'cx', x
    @circle.attr 'cy', y


  onClickEye: (e) ->
    target = $(e.currentTarget)
    value = target.val()

    @buttons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set 'size', value
    @circle.attr 'r', value

module.exports = CenterEyeSizeStep
