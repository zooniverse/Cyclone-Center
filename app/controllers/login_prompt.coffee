User = require 'zooniverse/lib/models/user'
Dialog = require 'zooniverse/lib/dialog'
LoginForm = require 'zooniverse/lib/controllers/login_form'

class LoginPrompt
  classifier: null
  title: 'You\'re not logged in'
  content: 'Logging in allows us to give you credit for you work.'

  classificationCount: 0

  promptDialog: null
  loginForm: null
  loginDialog: null

  constructor: (params = {}) ->
    @[property] = value for own property, value of params

    @promptDialog = new Dialog
      title: @title
      content: @content
      buttons: [{'Log in': true}, {'No thanks': false}]
      callback: @onClickLogIn

    @loginForm = new LoginForm

    @loginDialog = new Dialog
      content: @loginForm.el
      buttons: ['Cancel': null]

    User.bind 'sign-in', @onSignIn
    @classifier.bind 'classify', @onClassify

  onClassify: =>
    return if User.current

    @classificationCount += 1
    if @classificationCount in [3, 9]
      console.log "#{@classificationCount} classifications, login prompt opening"
      @promptDialog.open()

  onClickLogIn: (saidOkay) =>
    return unless saidOkay
    @loginDialog.open()

  onSignIn: =>
    return unless User.current

    console.log 'User signed in, login prompt closing'
    @classificationCount = 0
    @loginDialog.close()
    @promptDialog.close()

module.exports = LoginPrompt
