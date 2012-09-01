$ = require 'jqueryify'

$(document).on 'click', 'button[name="field-guide"]', ({currentTarget}) ->
  $('html').toggleClass 'show-field-guide', $(currentTarget).attr('value') is 'show'

class FieldGuide
  constructor: ({@el}) ->
    @el = $(@el)

    @el.on 'click', 'button[name="page"]', ({currentTarget}) =>
      page = $(currentTarget).attr 'value'

      @el.find('button[name="page"]').removeClass 'selected'
      $(currentTarget).addClass 'selected'

      @el.find('[data-page]').hide()
      @el.find("[data-page='#{page}']").show()

    @el.find('button[name="page"]').first().click()

module.exports = FieldGuide
