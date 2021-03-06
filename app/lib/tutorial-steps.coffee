translate = require 't7e'
{Step} = require 'zootorial'

module.exports =
  length: 17

  welcome: new Step
    number: 0
    header: translate 'span', 'tutorial.welcome.header'
    details: translate 'span', 'tutorial.welcome.details'
    block: '.controls, button[name="restart"]'
    next: 'temperature'
    onEnter: -> translate.refresh()
  
  temperature: new Step
    number: 1
    header: translate 'span', 'tutorial.temperature.header'
    details: translate 'span', 'tutorial.temperature.details'
    block: '.controls, button[name="restart"]'
    next: 'chooseStronger'
    onEnter: -> translate.refresh()

  chooseStronger: new Step
    number: 2
    header: translate 'span', 'tutorial.chooseStronger.header'
    details: translate 'span', 'tutorial.chooseStronger.details'
    instruction: translate 'span', 'tutorial.chooseStronger.instruction'
    attachment: 'left middle .subject .current right middle'
    block: 'button[name="restart"]'
    next:
      'click .subject .current, button[value="current"]': 'postStronger'
      'click .subject .older, button[value="older"], button[value="same"]': false
    onEnter: -> translate.refresh()

  postStronger: new Step
    number: 3
    header: translate 'span', 'tutorial.postStronger.header'
    details: translate 'span', 'tutorial.postStronger.details'
    instruction: translate 'span', 'tutorial.postStronger.instruction'
    attachment: 'center bottom button[name="continue"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[name="continue"]': 'chooseEmbeddedType'
    onEnter: -> translate.refresh()

  chooseEmbeddedType: new Step
    number: 4
    header: translate 'span', 'tutorial.chooseEmbeddedType.header'
    details: translate 'span', 'tutorial.chooseEmbeddedType.details'
    instruction: translate 'span', 'tutorial.chooseEmbeddedType.instruction'
    attachment: 'left middle .subject .current right middle'
    block: 'button[name="category"]:not([value="embedded"]), button[name="restart"]'
    next:
      'click button[value="embedded"]': 'chooseEyeType'
      'click button:not([value="embedded"])': false
    onEnter: -> translate.refresh()

  chooseEyeType: new Step
    number: 5
    header: translate 'span', 'tutorial.chooseEyeType.header'
    details: translate 'span', 'tutorial.chooseEyeType.details'
    instruction: translate 'span', 'tutorial.chooseEyeType.instruction'
    attachment: 'left bottom button[value="eye"] left top'
    block: 'button[name="category"]:not([value="eye"]), button[name="match"], button[name="restart"]'
    next:
      'click button[value="eye"]': 'chooseMatch'
      'click button:not([value="eye"])': false
    onEnter: -> translate.refresh()

  chooseMatch: new Step
    number: 6
    header: translate 'span', 'tutorial.chooseMatch.header'
    details: translate 'span', 'tutorial.chooseMatch.details'
    instruction: translate 'span', 'tutorial.chooseMatch.instruction'
    attachment: 'center bottom button[value="eye-7.0"] center top'
    block: 'button[name="category"]:not([value="eye"]), button[name="match"]:not([value="eye-7.0"])'
    next:
      'click button[value="eye-7.0"]': 'postMatch'
    onEnter: -> translate.refresh()

  postMatch: new Step
    number: 7
    header: translate 'span', 'tutorial.postMatch.header'
    details: translate 'span', 'tutorial.postMatch.details'
    instruction: translate 'span', 'tutorial.postMatch.instruction'
    attachment: 'center bottom button[name="continue"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[name="continue"]': 'chooseCenter'
    onEnter: -> translate.refresh()

  chooseCenter: new Step
    number: 8
    header: translate 'span', 'tutorial.chooseCenter.header'
    details: translate 'span', 'tutorial.chooseCenter.details'
    instruction: translate 'span', 'tutorial.chooseCenter.instruction'
    attachment: 'left middle .subject .current right middle'
    block: 'button[name="restart"]'
    next:
      'mouseup .subject': 'chooseSize'
    onEnter: -> translate.refresh()

  chooseSize: new Step
    number: 9
    header: translate 'span', 'tutorial.chooseSize.header'
    details: translate 'span', 'tutorial.chooseSize.details'
    instruction: translate 'span', 'tutorial.chooseSize.instruction'
    attachment: 'center bottom button[value="50"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[value="30"]': 'postChooseSize'
    onEnter: -> translate.refresh()

  postChooseSize: new Step
    number: 10
    header: translate 'span', 'tutorial.postChooseSize.header'
    details: translate 'span', 'tutorial.postChooseSize.details'
    instruction: translate 'span', 'tutorial.postChooseSize.instruction'
    attachment: 'center bottom button[name="continue"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[name="continue"]': 'chooseSurrounding'
    onEnter: -> translate.refresh()

  chooseSurrounding: new Step
    number: 11
    header: translate 'span', 'tutorial.chooseSurrounding.header'
    details: translate 'span', 'tutorial.chooseSurrounding.details'
    instruction: translate 'span', 'tutorial.chooseSurrounding.instruction'
    attachment: 'left middle .subject .current right middle'
    block: 'button[name="restart"]'
    next:
      'click button[value="-69"]': 'postSurrounding'
    onEnter: -> translate.refresh()

  postSurrounding: new Step
    number: 12
    header: translate 'span', 'tutorial.postSurrounding.header'
    details: translate 'span', 'tutorial.postSurrounding.details'
    instruction: translate 'span', 'tutorial.postSurrounding.instruction'
    attachment: 'center bottom button[name="continue"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[name="continue"]': 'chooseColdestThick'
    onEnter: -> translate.refresh()

  chooseColdestThick: new Step
    number: 13
    header: translate 'span', 'tutorial.chooseColdestThick.header'
    details: translate 'span', 'tutorial.chooseColdestThick.details'
    instruction: translate 'span', 'tutorial.chooseColdestThick.instruction'
    attachment: 'left middle .subject .current right middle'
    block: 'button[name="restart"]'
    next:
      'click button[value="-69"]': 'postColdestThick'
    onEnter: -> translate.refresh()

  postColdestThick: new Step
    number: 14
    header: translate 'span', 'tutorial.postColdestThick.header'
    details: translate 'span', 'tutorial.postColdestThick.details'
    instruction: translate 'span', 'tutorial.postColdestThick.instruction'
    attachment: 'center bottom button[name="continue"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[name="continue"]': 'chooseBandingFeature'
    onEnter: -> translate.refresh()

  chooseBandingFeature: new Step
    number: 15
    header: translate 'span', 'tutorial.chooseBandingFeature.header'
    details: translate 'span', 'tutorial.chooseBandingFeature.details'
    instruction: translate 'span', 'tutorial.chooseBandingFeature.instruction'
    attachment: 'left middle .subject .current right middle'
    block: 'button[name="restart"]'
    next:
      'click button[value="0.0"]': 'postBandingFeature'
    onEnter: -> translate.refresh()

  postBandingFeature: new Step
    number: 16
    header: translate 'span', 'tutorial.postBandingFeature.header'
    details: translate 'span', 'tutorial.postBandingFeature.details'
    instruction: translate 'span', 'tutorial.postBandingFeature.instruction'
    attachment: 'center bottom button[name="continue"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[name="continue"]': 'goodLuck'
    onEnter: -> translate.refresh()

  goodLuck: new Step
    number: 17
    header: translate 'span', 'tutorial.goodLuck.header'
    details: translate 'span', 'tutorial.goodLuck.details'
    instruction: translate 'span', 'tutorial.goodLuck.instruction'
    attachment: 'center bottom button[name="next"] center top'
    block: 'button[name="restart"]'
    next:
      'click button[name="next"]': null
    onEnter: -> translate.refresh()
