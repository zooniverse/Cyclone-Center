Step = require './base-step'
template = require '../../views/classify-steps/surrounding'
translate = require 't7e'
$ = require 'jqueryify'

class Surrounding extends Step
  property: 'surrounding'

  template: template
  explanation: translate 'div', 'classify.details.surrounding'

  events:
    'click button[name="surrounding"]': 'onClickColor'

  elements:
    'button[name="surrounding"]': 'buttons'

  reset: ->
    super
    @buttons.removeClass 'active'

  onClickColor: (e) ->
    target = $(e.currentTarget)

    @buttons.removeAttr 'active'
    target.addClass 'active'

    @classifier.classification.set @property, target.val()

module.exports = Surrounding
