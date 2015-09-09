t = require 't7e'

module?.exports = ->
  [
    {
      image: './images/site-intro/welcome.jpg'
      title: t 'span', 'siteIntro.1.tite'
      content: t 'span', 'siteIntro.1.content'
    },
    {
      image: './images/site-intro/stronger-storm.gif'
      title: t 'span', 'siteIntro.2.title'
      content: t 'span', 'siteIntro.2.content'
    },
    {
      image: './images/site-intro/additional-questions.gif'
      title: t 'span', 'siteIntro.3.title'
      content: t 'span', 'siteIntro.3.content'
    },
    {
      image: './images/site-intro/tutorial.gif'
      title: t 'span', 'siteIntro.4.title'
      content: t 'span', 'siteIntro.4.content'
    },
    {
      image: './images/site-intro/final.jpg'
      title: t 'span', 'siteIntro.5.title'
      content: t 'span', 'siteIntro.5.content'
    }
  ]
