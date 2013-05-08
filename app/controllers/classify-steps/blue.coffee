Step = require './base-step'
template = require '../../views/classify-steps/blue'
$ = require 'jqueryify'

class Blue extends Step
  property: 'blue'

  template: template

  events:
    'click button[name="blue"]': 'onClickButton'

  elements:
    'button[name="blue"]': 'buttons'

  onClickButton: (e) ->
    target = $(e.currentTarget)

    @buttons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set @property, target.val()

module.exports = Blue
