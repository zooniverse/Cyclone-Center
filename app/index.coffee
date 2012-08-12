Spine = require 'spine'
Manager = require 'spine/lib/manager'
Route = require 'spine/lib/route'

Config = require 'lib/config'
Api = require 'Zooniverse/lib/api'
TopBar = require 'Zooniverse/lib/controllers/top_bar'

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

    @topBar = new TopBar
      languages:
        en: 'English'
      app: 'Cyclone Center'

    @topBar.el.prependTo 'body'

    window.classifier = new Classifier el: '#classify .classifier'

    Route.setup()

AutoPopup.init()

module.exports = App

window.reCSS = ->
  link = $('link[href*="application.css"]')
  href = link.attr 'href'
  href += '?x=x' unless ~href.indexOf '?x=x'
  link.attr 'href', href + 'x'
