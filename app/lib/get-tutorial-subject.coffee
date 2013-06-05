Subject = require 'zooniverse/models/subject'

getTutorialSubject = ->
  new Subject
    id: '50575c4c516bcb571702112f'
    zooniverse_id: 'ACC0002uxn'
    group_id: '50575c4b516bcb57170210e4'

    location:
      'GMS-1': '//www.cyclonecenter.org/subjects/standard/50575c4c516bcb571702112f_gms-5.png'
      'GMS-1-yesterday': '//www.cyclonecenter.org/subjects/standard/50575c4c516bcb5717021121_gms-5.png'

    coords: [11.0, 153.863]

    metadata:
      tutorial: true

module.exports = getTutorialSubject
