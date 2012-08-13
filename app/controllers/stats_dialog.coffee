Spine = require('spine')
Dialog = require('zooniverse/lib/dialog')

class StatsDialog extends Dialog
  storm: ''

  constructor: ->
    super

    @title = "Stats for #{@storm}"
    @content = 'Loading stats...'
    
module.exports = StatsDialog
