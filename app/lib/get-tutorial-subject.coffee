Subject = require 'zooniverse/models/subject'

getTutorialSubject = ->
  new Subject
    id: 'TODO'
    zooniverseId: 'TODO'
    group_id: '50575f5e516bcb571702ad47'

    location:
      'FOO-1': '//placehold.it/600.png'
      'FOO-1-yesterday': '//placehold.it/600.png'

    coords: [0, 0]

    metadata:
      tutorial: true

module.exports = getTutorialSubject
