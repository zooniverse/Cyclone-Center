Step = require './base-step'
translate = require 't7e'

class Match extends Step
  property: 'strength'

  template: require '../../views/classify-steps/stronger'
  explanation: translate 'div', 'classify.steps.stronger.explanation'

  events:
    'click button[name="stronger"][value="older"], .subject .older': 'onClickOlder'
    'click button[name="stronger"][value="same"]': 'onClickSame'
    'click button[name="stronger"][value="current"], .subject .current': 'onClickCurrent'

  elements:
    'button[name="stronger"][value="older"]': 'olderButton'
    'button[name="stronger"][value="same"]': 'sameButton'
    'button[name="stronger"][value="current"]': 'currentButton'

  reset: ->
    super
    @classifier.currentImg.add(@currentButton).removeClass 'active'
    @classifier.olderImg.add(@olderButton).removeClass 'active'
    @sameButton.removeClass 'active'

  onClickOlder: ->
    @classifier.currentImg.add(@currentButton).removeClass 'active'
    @classifier.olderImg.add(@olderButton).addClass 'active'
    @sameButton.removeClass 'active'
    @classifier.classification.set @property, 'decrease'

  onClickCurrent: ->
    @classifier.currentImg.add(@currentButton).addClass 'active'
    @classifier.olderImg.add(@olderButton).removeClass 'active'
    @sameButton.removeClass 'active'
    @classifier.classification.set @property, 'increase'

  onClickSame: ->
    @classifier.currentImg.add(@currentButton).removeClass 'active'
    @classifier.olderImg.add(@olderButton).removeClass 'active'
    @sameButton.addClass 'active'
    @classifier.classification.set @property, 'same'

module.exports = Match
