translate = require 't7e'
enUs = require './lib/en-us'
translate.load enUs

Api = require 'zooniverse/lib/api'
api = new Api project: 'cyclone_center'

Subject = require 'zooniverse/models/subject'
Subject.group = true # Changes from Home page

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.appendTo document.body

Navigable = require 'navigable'
Home = require './controllers/home'
About = require './controllers/about'
Classify = require './controllers/classify'
Profile = require 'zooniverse/controllers/profile'
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

window.app = {api, navigation, stack, topBar}
module.exports = window.app
