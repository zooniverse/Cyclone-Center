Spine = require 'spine'
Manager = require 'spine/lib/manager'
Route = require 'spine/lib/route'

Config = require 'lib/config'
Api = require 'Zooniverse/lib/api'

Classifier = require 'controllers/classifier'
Profile = require 'controllers/profile'
AutoPopup = require 'Zooniverse/lib/auto_popup'

class App extends Manager.Stack
  controllers:
    # Using anonymous classes since we only need them for this stack.
    home: class extends Spine.Controller then el: '#home'
    about: class extends Spine.Controller then el: '#about'
    classify: class extends Spine.Controller then el: '#classify'
    profile: class extends Profile then el: '#profile'

  default: 'home'

  routes:
    '/': 'home'
    '/home': 'home'
    '/about': 'about'
    '/classify': 'classify'
    '/profile': 'profile'

  constructor: ->
    super

    Api.init host: Config.apiHost

    window.classifier = new Classifier el: '#classify .classifier'

    Route.setup()

AutoPopup.init()

module.exports = App
