BaseController = require 'zooniverse/controllers/base-controller'

class Navigation extends BaseController
  className: 'site-navigation'
  template: require '../views/navigation'

  elements:
    '.menu a': 'links'

  constructor: ->
    super
    addEventListener 'hashchange', @onHashChange, false
    @onHashChange()

  onHashChange: =>
    @links
      .removeClass('active')
      .filter (i) ->
        !window.location.hash.indexOf $(@).attr 'href'
      .addClass('active')

module.exports = Navigation
