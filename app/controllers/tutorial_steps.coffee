{Step} = require 'zooniverse/lib/controllers/tutorial'

module.exports = [
  new Step
    title: 'Welcome to Cyclone Center!'
    content:'''
      <p>In this project, we\'ll be classifying satellite images of storms. Let's take a quick look at the classification interface.</p>
    '''
    attachment: to: '.main-pair'

  new Step
    title: 'Subject'
    content: '''
      This is a satellite image of a storm you're classifying.

    '''
    attachment: arrowDirection: 'right', x: 'right', to: '.classifier img.subject', at: x: 'left'

  new Step
    title: 'Instructions'
    content: '''
      <p>Each type of storm requires different questions to be answered. Read the question below the subject and answer as best you can.</p>
      <p>Classifying storms is very subjective process, so use your best judgement and don't worry about being right or wrong.</p>
      <p>We'll combine your observations with the observations of other volunteers to come to a conclusion.</p>
    '''
    attachment: arrowDirection: 'bottom', y: 'bottom', to: '.classifier .step', at: y: 'top'

  new Step
    title: 'Get help'
    content: '''
      <p>Click the "?" buttons to get help if you're not sure what an instruction is asking you to do.</p>
    '''
    attachment: arrowDirection: 'bottom', y: 'bottom', to: '.classifier .help, .classifier .help-ball', at: y: 'top'

  new Step
    title: 'Progress'
    content: '''
      <p>After classifying six images, you'll get access to additional information about the storm.</p>
      <p>You'll also have an opportunity to mark an image as a favorite or discuss it with other volunteers in Talk.</p>
      <p>You can check your progress here.</p>
    '''
    attachment: arrowDirection: 'bottom', y: 'bottom', to: '.classifier .progress', at: y: 'top'

  new Step
    title: 'Reset'
    content: '''
      <p>Make a mistake? Start your classification over with this button.</p>
    '''
    attachment: arrowDirection: 'bottom', y: 'bottom', to: '.classifier button[name="restart"]', at: y: 'top'

  new Step
    title: 'Detailed classification'
    content: '''
      <p>Once you're comfortable identifying different types of storms, we'd like you to go into a little more detail by answering some additional questions.</p>
      <p>Check this box to be asked the additional questions. Remember, they're subjective, so just use your best judgement.</p>
    '''
    attachment: arrowDirection: 'bottom', y: 'bottom', to: '.classifier input[name="detailed"]', at: y: 'top'

  new Step
    title: 'Have fun!'
    content: '''
      <p>Remember, there's no right or wrong answer to any of these. We're using classifications from multiple people to get the best look at how a storm changes.</p>
      <p>Thanks for helping!</p>
    '''
    attachment: to: '.classifier'
]
