translate = require 't7e'
enUs = require './lib/en-us'
translate.load enUs

Api = require 'zooniverse/lib/api'
api = new Api project: 'cyclone_center'

Subject = require 'zooniverse/models/subject'
Subject.group = true

LanguageManager = require 'zooniverse/lib/language-manager'
languageManager = new LanguageManager
  translations:
    en: label: 'English', strings: enUs

languageManager.on 'change-language', (e, code, strings) ->
  translate.load strings
  translate.refresh()

$app = $('#app')
$footerContainer = $('#footer-container')

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.prependTo document.body

StackOfPages = require 'stack-of-pages'
stack = new StackOfPages
  '#/home': require './controllers/home'
  '#/about/*': require './controllers/about'
  '#/classify': require './controllers/classify'
  '#/profile': require './controllers/profile'
$(stack.el).appendTo $app

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar
topBar.el.appendTo navigation.el

Footer = require 'zooniverse/controllers/footer'
footer = new Footer
footer.el.appendTo $footerContainer

User = require 'zooniverse/models/user'
User.fetch()

GoogleAnalytics = require 'zooniverse/lib/google-analytics'
analytics = new GoogleAnalytics account: 'UA-1224199-33'

module.exports = window.app = { api, navigation, stack, topBar, analytics }
