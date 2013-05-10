translate = require 't7e'
enUs = require './lib/en-us'
t7e.load enUs

Api = require 'zooniverse/lib/api'
api = new Api project: 'cyclone_center'

# groups = [
#   '5057531d516bcb5717000001'
#   '5057531d516bcb571700000d'
#   '5057531d516bcb571700001d'
#   '5057531e516bcb5717000046'
# ]

Subject = require 'zooniverse/models/subject'
Subject.group = true # Changes from Home page

Navigation = require './controllers/navigation'
navigation = new Navigation
navigation.el.appendTo document.body

Navigable = require 'navigable'
Home = require './controllers/home'
Classify = require './controllers/classify'
stack = Navigable.stack [
  {'Home': new Home}
  {'About': 'This is the about page'}
  {'Classify': new Classify}
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
