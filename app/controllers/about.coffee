BaseController = require 'zooniverse/controllers/base-controller'
translate = require 't7e'
Dialog = require 'zooniverse/controllers/dialog'
StackOfPages = require 'stack-of-pages'

class About extends BaseController
  className: 'about'
  template: require '../views/about'
  elements:
    '.sub-section-menu li a': 'menuLinks'

  constructor: ->
    super
    @createPopups()
    
    aboutStack = new StackOfPages
      '#/about': require('../views/about/overview')()
      '#/about/introduction': require('../views/about/introduction')()
      '#/about/organizations': require('../views/about/organizations')()
      '#/about/team': require('../views/about/team')()

    @el.find('#about-stack').append aboutStack.el
    @el.on StackOfPages::activateEvent, @activate

  activate: ({ originalEvent: { detail }}) =>
    @menuLinks.removeClass 'active'
    @menuLinks.filter("[href=\"#{ detail.hash }\"]").addClass 'active'

  createPopups: =>
    dialogTriggers = @el.find '[data-popup]'

    for trigger in dialogTriggers then do (trigger) =>
      trigger = $(trigger)
      target = trigger.attr 'data-popup'
      content = @el.find(target).first()

      return if content.length is 0

      closeButton = $('<button name="close-dialog">&times;</button>')
      content.append closeButton

      dialog = new Dialog
        className: "#{Dialog::className} about"
        content: content

      trigger.on 'click', ->
        dialog.show()
        closeButton.focus()

    null

module.exports = About
