Step = require './base-step'
template = require '../../views/classify-steps/curve'
translate = require 't7e'

$ = require 'jqueryify'

class Curve extends Step
  property: 'curve'

  template: template
  explanation: translate 'div', 'classify.details.curve'

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
