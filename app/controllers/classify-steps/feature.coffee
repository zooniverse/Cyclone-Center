Step = require './base-step'
template = require '../../views/classify-steps/feature'
translate = require 't7e'

$ = require 'jqueryify'

class Feature extends Step
  property: 'feature'

  template: template
  explanation: translate 'div', 'classify.details.feature'

  events:
    'click button[name="feature"]': 'onClickButton'

  elements:
    'button[name="feature"]': 'buttons'

  onClickButton: (e) ->
    target = $(e.currentTarget)

    @buttons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set @property, target.val()

module.exports = Feature
