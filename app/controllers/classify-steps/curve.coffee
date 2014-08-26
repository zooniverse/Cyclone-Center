Step = require './base-step'
translate = require 't7e'
$ = window.jQuery

class Curve extends Step
  property: 'band_wrap'

  template: require '../../views/classify-steps/curve'
  explanation: translate 'div', 'classify.steps.curve.explanation'

  events:
    'click button[name="curve"]': 'onClickButton'

  elements:
    'button[name="curve"]': 'buttons'

  reset: ->
    super
    @buttons.removeClass 'active'

  onClickButton: (e) ->
    target = $(e.currentTarget)

    @buttons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set @property, target.val()

module.exports = Curve
