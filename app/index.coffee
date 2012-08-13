Spine = require 'spine'
Manager = require 'spine/lib/manager'
Route = require 'spine/lib/route'

Config = require 'lib/config'
Api = require 'zooniverse/lib/api'
TopBar = require 'zooniverse/lib/controllers/top_bar'

Classifier = require 'controllers/classifier'
Profile = require 'controllers/profile'
autoPopup = require 'zooniverse/lib/auto_popup'
activeHashLinks = require 'zooniverse/lib/active_hash_links'

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

autoPopup.init()
activeHashLinks.init()

module.exports = App

window.reCSS = ->
  link = $('link[href*="application.css"]')
  href = link.attr 'href'
  href += '?x=x' unless ~href.indexOf '?x=x'
  link.attr 'href', href + 'x'
