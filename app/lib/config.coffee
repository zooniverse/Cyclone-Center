base =
  setSize: 6

config =
  test:
    apiHost: null

  development:
    apiHost: 'https://dev.zooniverse.org'

  production:
    apiHost: 'https://api.zooniverse.org'

env = if window.jasmine
  'test'
else if +window.location.port >= 1024
  'development'
else
  'production'

module.exports = $.extend {}, base, config[env]
