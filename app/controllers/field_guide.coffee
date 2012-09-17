$ = require 'jqueryify'

class FieldGuide
  constructor: ({@el}) ->
    @el = $(@el)
    @addCloseButton()

    $(document).on 'click', '[data-guide]', ({currentTarget}) =>
      page = $(currentTarget).attr 'data-guide'
      console.log "Opening field guide to #{page}"
      @open page

  addCloseButton: ->
    @el.prepend '<button name="close" title="Close field guide">&times;</button>'
    @el.on 'click', 'button[name="close"]', =>
      @close()

  open: (page) ->
    @el.find('[data-page]').hide()
    @el.find("[data-page='#{page}']").show()
    @el.addClass 'open'

  close: ->
    @el.removeClass 'open'

module.exports = FieldGuide
