Step = require './base-step'
translate = require 't7e'
$ = window.jQuery

class Blue extends Step
  property: 'coldest_band_color'

  template: require '../../views/classify-steps/blue'
  explanation: translate 'div', 'classify.steps.blue.explanation'

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
    target.prevAll().addBack().addClass 'active'

    @classifier.classification.set @property, parseFloat target.val()

module.exports = Blue
