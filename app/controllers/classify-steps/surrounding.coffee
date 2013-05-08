Step = require './base-step'
template = require '../../views/classify-steps/surrounding'
$ = require 'jqueryify'

class Surrounding extends Step
  property: 'surrounding'
  template: template

  events:
    'click button[name="surrounding"]': 'onClickColor'

  elements:
    'button[name="surrounding"]': 'buttons'

  onClickColor: (e) ->
    target = $(e.currentTarget)

    @buttons.removeAttr 'active'
    target.addClass 'active'

    @classifier.classification.set @property, target.val()

module.exports = Surrounding
