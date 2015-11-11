Meteor.publish 'postsOfTopic', (topic_id, page_number, posts_per_page) ->
    Filter.Posts.by(topic_id, page_number, posts_per_page)
