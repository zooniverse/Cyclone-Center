t = require 't7e'

module?.exports = ->
  imageOne = t('span', 'siteIntro.one.image')
  imageTwo = t('span', 'siteIntro.two.image')
  imageThree = t('span', 'siteIntro.three.image')
  imageFour = t('span', 'siteIntro.four.image')
  imageFive = t('span', 'siteIntro.five.image')

  [
    {
      image: $(imageOne).html()
      title: t('span', 'siteIntro.one.title')
      content: t('span', 'siteIntro.one.content')
    },
    {
      image: $(imageTwo).html()
      title: t('span', 'siteIntro.two.title')
      content: t('span', 'siteIntro.two.content')
    },
    {
      image: $(imageThree).html()
      title: t('span', 'siteIntro.three.title')
      content: t('span', 'siteIntro.three.content')
    },
    {
      image: $(imageFour).html()
      title: t('span', 'siteIntro.four.title')
      content: t('span', 'siteIntro.four.content')
    },
    {
      image: $(imageFive).html()
      title: t('span', 'siteIntro.five.title')
      content: t('span', 'siteIntro.five.content')
    }
  ]
