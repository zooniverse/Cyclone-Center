require 'lib/setup'

Spine = require('spine')
Manager = require('spine/lib/manager')
Route = require('spine/lib/route')
Classifier = require('controllers/classifier')

class App extends Manager.Stack
  controllers:
    # Using anonymous classes since we only need them for this stack.
    home: class extends Spine.Controller then el: '#home'
    classify: class extends Spine.Controller then el: '#classify'

  default: 'home'

  routes:
    '/': 'home'
    '/home': 'home'
    '/classify': 'classify'

  constructor: ->
    super
    Route.setup()

    window.classifier = new Classifier el: '#classify .classifier'

module.exports = App
