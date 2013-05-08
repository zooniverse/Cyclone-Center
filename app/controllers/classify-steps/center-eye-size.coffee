CenterStep = require './center'
template = require '../../views/classify-steps/center-eye-size'
$ = require 'jqueryify'

class CenterEyeSizeStep extends CenterStep
  property: ['center', 'size']
  template: template

  events: ($.extend {}, CenterStep::events,
    'click button[name="eye"]': 'onClickEye'
  )

  elements: ($.extend {}, CenterStep::elements,
    'button[name="size"]': 'sizeButtons'
  )

  onClickEye: (e) ->
    target = $(e.currentTarget)

    @sizeButtons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set 'size', target.val()

module.exports = CenterEyeSizeStep
