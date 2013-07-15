$ = window.jQuery
User = require 'zooniverse/models/user'
Api = require 'zooniverse/lib/api'

class PreferenceCheckbox
  label: 'Preference?'
  setting: 'UNDEFINED_PREFERENCE'
  checkedValue: 'Y'
  uncheckedValue: ''

  el: null
  checkbox: null

  constructor: (params = {}) ->
    @[property] = value for property, value of params

    @el = $("""
      <label class="preference-input">
        <input type="checkbox" />
        <span class="label-text">#{@label}</span>
      </label>
    """)

    @checkbox = @el.find 'input'
    @checkbox.prop 'checked', User.current?.preferences?[Api.current.project]?[@setting] is @value
    @checkbox.on 'change', @onChange

    User.on 'change', @onUserChange
    @onUserChange()

  onUserChange: =>
    @el.toggleClass 'signed-in', User.current?
    @checkbox.attr disabled: not User.current?
    project = Api.current.project
    @checkbox.prop 'checked', User.current?.preferences?[project]?[@setting] is @checkedValue

  onChange: =>
    checked = @checkbox.prop 'checked'
    value = if checked then @checkedValue else @uncheckedValue

    User.current?.setPreference @setting, value

module.exports = PreferenceCheckbox
