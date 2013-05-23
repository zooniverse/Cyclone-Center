Step = require './base-step'
template = require '../../views/classify-steps/blue'
translate = require 't7e'
$ = window.jQuery

class Blue extends Step
  property: 'coldest_band_color'

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
    target.prevAll().andSelf().addClass 'active'

    @classifier.classification.set @property, parseFloat target.val()

module.exports = Blue
