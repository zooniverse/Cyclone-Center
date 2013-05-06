Controller = require 'zooniverse/controllers/base-controller'
template = require '../views/home'

class Home extends Controller
  className: 'home'
  template: template

module.exports = Home
