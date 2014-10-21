BaseController = require 'zooniverse/controllers/base-controller'

class Navigation extends BaseController
  className: 'site-navigation'
  template: require '../views/navigation'

  elements:
    '.menu a': 'links'
    '.menu-list li': 'menuList'

  events:
    'click .hamburger-menu': 'onClickHamburger'
    'click a': 'onChangePage'  

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

  onClickHamburger: =>  
    @menuList.slideToggle(200)

  onChangePage: =>
    if window.innerWidth < 625
      @menuList.slideUp(200)
      

module.exports = Navigation
