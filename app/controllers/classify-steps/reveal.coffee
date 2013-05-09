Step = require './base-step'
template = require '../../views/classify-steps/reveal'
$ = require 'jqueryify'

class Reveal extends Step
  template: template

module.exports = Reveal
