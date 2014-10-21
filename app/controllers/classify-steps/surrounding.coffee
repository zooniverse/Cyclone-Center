Step = require './base-step'
translate = require 't7e'
$ = window.jQuery

class Surrounding extends Step
  property: 'coldest_surrounding_eye'

  template: require '../../views/classify-steps/surrounding'
  explanation: translate 'div', 'classify.steps.surrounding.explanation'

  events:
    'click button[name="surrounding"]': 'onClickColor'

  elements:
    'button[name="surrounding"]': 'buttons'

  reset: ->
    super
    @buttons.removeClass 'active'

  onClickColor: (e) ->
    target = $(e.currentTarget)

    @buttons.removeClass 'active'
    target.prevAll().andSelf().addClass 'active'

    @classifier.classification.set @property, parseFloat target.val()

module.exports = Surrounding
