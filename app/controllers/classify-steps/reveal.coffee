Step = require './base-step'
detailsTemplate = require '../../views/classify-steps/reveal'
$ = require 'jqueryify'

class Reveal extends Step
  explanation: detailsTemplate @

  elements:
    '.map': 'mapContainer'
    '.graph': 'graphContainer'

  constructor: ->
    super
    window.reveal = @

module.exports = Reveal
