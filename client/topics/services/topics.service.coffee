angular.module 'topics'
.service 'topicsServ', ($meteor, $state) ->
    getPosts: (topic_id, page_number, posts_per_page) ->
        $meteor.collection ->
            Posts.find topic_id: topic_id,
                sort: createdAt: 1
                skip: (page_number - 1) * posts_per_page
                limit: posts_per_page
        .subscribe('postsOfTopic', topic_id, page_number, posts_per_page)
    getTopicById: (topic_id) ->
        $meteor.call 'getTopicById', topic_id
    create: (topic, section_id) ->
        $meteor.call('addTopic', topic).then ->
            $state.go('section.one.show', id: section_id)
    update: (topic) ->
        $meteor.call('updateTopic', topic).then ->
            $state.goBack()
    delete: (topic_id) ->
        $meteor.call('deleteTopic', topic_id).then ->
            $state.goBack()
