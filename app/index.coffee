window.jQuery = require 'jqueryify' # Global jQuery

translate = require 't7e'
enUs = require './lib/en-us'
t7e.load enUs

Api = require 'zooniverse/lib/api'
api = new Api project: 'cyclone_center'

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.appendTo document.body

Navigable = require 'navigable'
Home = require './controllers/home'
stack = Navigable.stack [
  {'Home': new Home}
  {'About': 'This is the about page'}
  {'Classify': 'This is the classify page'}
  {'Profile': 'This is the profile page'}
]

document.body.appendChild stack.el

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar
topBar.el.appendTo document.body

User = require 'zooniverse/models/user'
User.fetch()

window.app = {navigation, stack, topBar}
module.exports = window.app
