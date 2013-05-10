CenterStep = require './center'
template = require '../../views/classify-steps/center-eye-size'
translate = require 't7e'
$ = window.jQuery

class CenterEyeSizeStep extends CenterStep
  property: ['center', 'size']

  template: template
  explanation: translate 'div', 'classify.details.centerEyeSize'

  events: ($.extend {}, CenterStep::events,
    'click button[name="eye"]': 'onClickEye'
  )

  elements: ($.extend {}, CenterStep::elements,
    'button[name="eye"]': 'buttons'
  )

  reset: ->
    super
    @buttons.removeClass 'active'

  onClickEye: (e) ->
    target = $(e.currentTarget)

    @buttons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set 'size', target.val()

module.exports = CenterEyeSizeStep
