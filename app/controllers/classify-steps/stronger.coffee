Step = require './base-step'
template = require '../../views/classify-steps/stronger'

class Match extends Step
  template: template

  events:
    'click .subject .older': 'onClickOlder'
    'click .current': 'onClickCurrent'

  onClickOlder: ->
    @classifier.currentImg.removeClass 'active'
    @classifier.olderImg.addClass 'active'

  onClickCurrent: ->
    @classifier.currentImg.addClass 'active'
    @classifier.olderImg.removeClass 'active'

module.exports = Match
