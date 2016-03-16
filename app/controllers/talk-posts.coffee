Controller = require 'zooniverse/controllers/base-controller'
Api = require 'zooniverse/lib/api'
translate = require 't7e'

class TalkPosts extends Controller
  className: 'talk-posts'
  template: translate 'h2', 'home.talk.header'

  constructor: ->
    super
    @appendTalkPosts()

  appendTalkPosts: (numPosts = 3) ->
    Api.current.get "/projects/#{Api.current.project}/talk/recents/subjects", (posts) =>
      @el.append posts[0...numPosts].map(@formattedPost)

  talkSubjectUrl: (subjectName) ->
    "https://talk.cyclonecenter.org/#/subjects/#{subjectName}"

  formattedPost: (subjectData) =>
    {comment: {body, user_name}, focus: {location, name}} = subjectData
    firstLocation = location[Object.keys(location)[0]]

    "<div class='talk-post'>
      <a href='#{@talkSubjectUrl(name)}'> 
        <img src='#{firstLocation}' class='talk-post-thumbnail'/>
        <div class='talk-post-content'>
          <span class='talk-post-username'>#{user_name}</span> \"#{body}\" </br>
          <div class='link-to-talk'>#{ translate 'span', 'home.talk.viewDiscussion' }</div>
        </div>
      </a>
    </div>"

module?.exports = TalkPosts
