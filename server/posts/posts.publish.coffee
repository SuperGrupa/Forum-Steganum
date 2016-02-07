auth = require('authFunctions')

Meteor.publish 'postsOfTopic', (topic_id, page_number) ->
    if auth.can('read', 'topic', topic_id, this.userId)
        Filter.Posts.by topic_id,
            sort: createdAt: -1
            limit: 10
            skip: (page_number - 1)*10
