Step = require './base-step'
template = require '../../views/classify-steps/stronger'
translate = require 't7e'

class Match extends Step
  property: 'stronger'

  template: template
  explanation: translate 'div', 'classify.details.stronger'

  events:
    'click .subject .older': 'onClickOlder'
    'click .current': 'onClickCurrent'
    'click button[name="stronger"][value="same"]': 'onClickSame'

  elements:
    'button[name="stronger"][value="same"]': 'sameButton'

  onClickOlder: ->
    @classifier.currentImg.removeClass 'active'
    @classifier.olderImg.addClass 'active'
    @sameButton.removeClass 'active'
    @classifier.classification.set @property, false

  onClickCurrent: ->
    @classifier.currentImg.addClass 'active'
    @classifier.olderImg.removeClass 'active'
    @sameButton.removeClass 'active'
    @classifier.classification.set @property, true

  onClickSame: ->
    @classifier.currentImg.removeClass 'active'
    @classifier.olderImg.removeClass 'active'
    @sameButton.addClass 'active'
    @classifier.classification.set @property, 'SAME'

module.exports = Match
