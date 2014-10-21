Subject = require 'zooniverse/models/subject'

getTutorialSubject = ->
  new Subject
    id: '50575c4c516bcb571702112f'
    zooniverse_id: 'ACC0002uxn'
    group_id: '50575c4b516bcb57170210e4'
    workflow_ids: ['51b894903ae7403a84000001']

    location:
      'GMS-5': '//www.cyclonecenter.org/subjects/standard/50575c4c516bcb571702112f_gms-5.png'
      'GMS-5-yesterday': '//www.cyclonecenter.org/subjects/standard/50575c4c516bcb5717021121_gms-5.png'

    coords: [11.0, 153.863]

    metadata:
      available_satellites: ['GMS-5']
      tutorial: true

module.exports = getTutorialSubject
