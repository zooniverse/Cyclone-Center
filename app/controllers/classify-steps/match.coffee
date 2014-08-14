Step = require './base-step'
translate = require 't7e'
$ = window.jQuery

class Match extends Step
  property: ['type', 'match']

  template: require '../../views/classify-steps/match'
  explanation: translate 'div', 'classify.steps.catAndMatch.explanation'

  events:
    'click button[name="category"]': 'onClickCategory'
    'click button[name="match"]': 'onClickMatch'

  elements:
    'button[name="category"]': 'categoryButtons'
    '[data-category]': 'categoryLists'
    'button[name="match"]': 'matchButtons'

  reset: ->
    super
    @categoryButtons.removeClass 'active'
    @categoryLists.removeClass 'active'
    @matchButtons.removeClass 'active'

  onClickCategory: (e) ->
    target = $(e.currentTarget)
    category = target.val()

    @categoryButtons.removeClass 'active'
    target.addClass 'active'

    @categoryLists.removeClass 'active'
    @categoryLists.filter("[data-category='#{category}']").addClass 'active'

    @matchButtons.removeClass 'active'

    @classifier.classification.set @property[0], category
    @classifier.classification.set @property[1], null

  onClickMatch: (e) ->
    target = $(e.currentTarget)
    match = target.val()

    @matchButtons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set @property[1], match

module.exports = Match
