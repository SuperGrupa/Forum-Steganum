Meteor.publish 'postsOfTopic', (topic_id, page_number, posts_per_page) ->
    Posts.find { topic_id: topic_id },
        sort: createdAt: 1
        skip: (page_number - 1) * posts_per_page
        limit: posts_per_page
