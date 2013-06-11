Step = require './base-step'
template = require '../../views/classify-steps/stronger'
translate = require 't7e'

class Match extends Step
  property: 'strength'

  template: template
  explanation: translate 'div', 'classify.details.stronger'

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
    @classifier.classification.set @property, false

  onClickCurrent: ->
    @classifier.currentImg.add(@currentButton).addClass 'active'
    @classifier.olderImg.add(@olderButton).removeClass 'active'
    @sameButton.removeClass 'active'
    @classifier.classification.set @property, true

  onClickSame: ->
    @classifier.currentImg.add(@currentButton).removeClass 'active'
    @classifier.olderImg.add(@olderButton).removeClass 'active'
    @sameButton.addClass 'active'
    @classifier.classification.set @property, 'SAME'

module.exports = Match
