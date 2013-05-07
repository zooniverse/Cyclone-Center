Step = require './base-step'
template = require '../../views/classify-steps/match'
$ = require 'jqueryify'

class Match extends Step
  property: 'match'

  template: template

  events:
    'click button[name="category"]': 'onClickCategory'
    'click button[name="match"]': 'onClickMatch'

  elements:
    'button[name="category"]': 'categoryButtons'
    '[data-category]': 'categoryLists'
    'button[name="match"]': 'matchButtons'

  onClickCategory: (e) ->
    target = $(e.currentTarget)
    category = target.val()

    @categoryButtons.removeClass 'active'
    target.addClass 'active'

    @categoryLists.removeClass 'active'
    @categoryLists.filter("[data-category='#{category}']").addClass 'active'

    @matchButtons.removeClass 'active'

    @classifier.classification.set @property, null

  onClickMatch: (e) ->
    target = $(e.currentTarget)
    match = target.val()

    @matchButtons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set @property, match

module.exports = Match
