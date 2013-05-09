Step = require './base-step'
template = require '../../views/classify-steps/match'
translate = require 't7e'
$ = require 'jqueryify'

class Match extends Step
  property: ['category', 'match']

  template: template
  explanation: translate 'div', 'classify.details.catAndMatch'

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

    @classifier.classification.set 'category', target.val()
    @classifier.classification.set 'match', null

  onClickMatch: (e) ->
    target = $(e.currentTarget)
    match = target.val()

    @matchButtons.removeClass 'active'
    target.addClass 'active'

    @classifier.classification.set 'match', match

module.exports = Match
