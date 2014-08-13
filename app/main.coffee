translate = require 't7e'
enUs = require './lib/en-us'
translate.load enUs

Api = require 'zooniverse/lib/api'
api = new Api project: 'cyclone_center'

LanguageManager = require 'zooniverse/lib/language-manager'
languageManager = new LanguageManager
  translations:
    en: label: 'English', strings: enUs

languageManager.on 'change-language', (e, code, strings) ->
  translate.load strings
  translate.refresh()

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.appendTo document.body

Navigable = require 'navigable'
Home = require './controllers/home'
About = require './controllers/about'
Classify = require './controllers/classify'
Profile = require './controllers/profile'
stack = Navigable.stack [
  {'Home': new Home}
  {'About': new About}
  {'Classify': new Classify}
  {'Profile': new Profile}
]

document.body.appendChild stack.el

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar
topBar.el.appendTo document.body

User = require 'zooniverse/models/user'
User.fetch()

GoogleAnalytics = require 'zooniverse/lib/google-analytics'
analytics = new GoogleAnalytics account: 'UA-1224199-33'

window.app = {api, navigation, stack, topBar, analytics}
module.exports = window.app
