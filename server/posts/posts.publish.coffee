auth = require('authFunctions')

Meteor.publish 'postsOfTopic', (topic_id, page_number, posts_per_page) ->
    if auth.can('read', 'topic', topic_id, this.userId)
        Filter.Posts.by(topic_id, page_number, posts_per_page)
