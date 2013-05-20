BaseController = require 'zooniverse/controllers/base-controller'
translate = require 't7e'

class About extends BaseController
  className: 'about'
  template: translate 'div', 'about.content'

module.exports = About
