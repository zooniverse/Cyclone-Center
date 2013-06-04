Subject = require 'zooniverse/models/subject'

getTutorialSubject = ->
  new Subject
    id: 'TODO'
    zooniverseId: 'TODO'
    group_id: '50575f5e516bcb571702ad47'

    location:
      'FOO-1': '//www.cyclonecenter.org/subjects/standard/50575c4c516bcb571702112f_gms-5.png'
      'FOO-1-yesterday': '//www.cyclonecenter.org/subjects/standard/50575c4c516bcb5717021121_gms-5.png'

    coords: [0, 0]

    metadata:
      tutorial: true

module.exports = getTutorialSubject