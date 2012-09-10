{Step} = require 'zooniverse/lib/controllers/tutorial'

module.exports = [
  new Step
    title: 'Welcome to Cyclone Center!'
    content:'''
      In this project, we\'ll be classifying satellite images of storms.
      The classification process
    '''
    attachment: x: 'left'

  new Step
    title: 'Detailed classification'
    content: 'Once you\'re comfortable, check "detailed classification" to answer a few extra steps about each image.'
    attachment: x: 'right'
    nextOn: click: '*'
    block: 'nav'
]
