Step = require './base-step'
template = require '../../views/classify-steps/blue'
translate = require 't7e'
$ = require 'jqueryify'

class Blue extends Step
  property: 'blue'

  template: template
  explanation: translate 'div', 'classify.details.blue'

  events:
    'click button[name="blue"]': 'onClickButton'

  elements:
    'button[name="blue"]': 'buttons'

  reset: ->
    super
    @buttons.removeClass 'active'

  onClickButton: (e) ->
    target = $(e.currentTarget)

    @buttons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set @property, target.val()

module.exports = Blue
