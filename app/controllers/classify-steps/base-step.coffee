Controller = require 'zooniverse/controllers/base-controller'
$ = require 'jqueryify'

nextId = 0

class BaseStep
  classifier: null

  template: null
  controls: null

  property: ''

  events: null
  elements: null

  el: null

  constructor: (params = {}) ->
    @[property] = value for property, value of params
    @el = @classifier.el

    if @template?
      @controls = $(@template @)
      @controls.appendTo @classifier.stepControls
      @controls.hide()

    setTimeout =>
      Controller::nameElements.call @

  enter: ->
    @controls.show()
    Controller::delegateEvents.call @

  leave: ->
    @controls.hide()
    @el.off ".#{@id}"

module.exports = BaseStep
