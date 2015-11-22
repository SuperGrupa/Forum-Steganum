topicsServ = ($meteor, $state) ->
    getPosts: (topic_id, page_number, posts_per_page) ->
        images = $meteor.collection(Images).subscribe('images')
        posts = $meteor.collection ->
            Filter.Posts.by(topic_id, page_number, posts_per_page)
        .subscribe('postsOfTopic', topic_id, page_number, posts_per_page)
        return posts
    getTopicById: (topic_id) ->
        $meteor.call 'getTopicById', topic_id
    create: (topic) ->
        $meteor.call('addTopic', topic).then ->
            $state.go('section.one.show', id: topic.section_id)
    update: (topic) ->
        $meteor.call('updateTopic', topic).then ->
            $state.goBack()
    delete: (topic_id) ->
        $meteor.call('deleteTopic', topic_id).then ->
            $state.goBack()


topicsServ.$inject = ['$meteor', '$state']

angular.module 'topics'
.service 'topicsServ', topicsServ
