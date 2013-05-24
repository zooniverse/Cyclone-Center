BaseController = require 'zooniverse/controllers/base-controller'
translate = require 't7e'
Dialog = require 'zooniverse/controllers/dialog'

class About extends BaseController
  className: 'about'
  template: translate 'div', 'about.content'

  constructor: ->
    super
    @createPopups()

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
