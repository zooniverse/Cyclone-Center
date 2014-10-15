Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
TalkPosts = require './talk-posts'
{ formatNumber } = require '../lib/utils'

WP_API_URL = 'https://public-api.wordpress.com/rest/v1/sites/blog.cyclonecenter.org/posts/?number=4&fields=title,URL'

class Home extends Controller
  className: 'home'
  template: require '../views/home'
  previousPostsTemplate: require '../views/previous-posts'

  elements:
    '#user-count': 'userCount'
    '#classification-count': 'classificationCount'
    '#storms-complete': 'stormsComplete'
    '#latest-post': 'latestPost'
    '#previous-posts': 'previousPosts'
    '#latest-talk-posts': 'latestTalkPosts'

  constructor: ->
    super

    Api.current.get '/projects/cyclone_center', (project) =>
      { classification_count, complete_count, user_count } = project

      @userCount.html formatNumber user_count
      @classificationCount.html formatNumber classification_count
      @stormsComplete.html formatNumber complete_count

    $.getJSON WP_API_URL, ({ posts: [latestPost, previousPosts...] }) =>
      @latestPost.html "<a href=\"#{ latestPost.URL }\" target=\"_blank\">#{ latestPost.title }</a>"
      @previousPosts.html @previousPostsTemplate({ previousPosts })

    @talkPosts = new TalkPosts
    @latestTalkPosts.html @talkPosts.el

module.exports = Home
