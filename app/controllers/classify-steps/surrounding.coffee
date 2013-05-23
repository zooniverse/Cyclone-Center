Step = require './base-step'
template = require '../../views/classify-steps/surrounding'
translate = require 't7e'
$ = window.jQuery

class Surrounding extends Step
  property: 'coldest_surrounding_eye'

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

    @buttons.removeClass 'active'
    target.prevAll().andSelf().addClass 'active'

    @classifier.classification.set @property, parseFloat target.val()

module.exports = Surrounding
