topicsServ = ($meteor, $state, alertsServ) ->
    getPosts: (topic_id, page_number, posts_per_page) ->
        $meteor.collection ->
            Filter.Posts.by(topic_id, page_number, posts_per_page)
        .subscribe('postsOfTopic', topic_id, page_number, posts_per_page)
    getTopicById: (topic_id) ->
        $meteor.call 'getTopicById', topic_id
    create: (topic) ->
        $meteor.call('addTopic', topic).then ->
            alertsServ.success('New Topic', 'You\'ve created a new topic')
            $state.go('section.one.show', id: topic.section_id)
        , (error) ->
            alertsServ.error(error)
    update: (topic) ->
        $meteor.call('updateTopic', topic).then ->
            alertsServ.success('Update Topic', 'You\'ve updated a topic')
            $state.goBack()
        , (error) ->
            alertsServ.error(error)
    delete: (topic_id) ->
        $meteor.call('deleteTopic', topic_id).then ->
            alertsServ.success('Remove Topic', 'You\'ve removed a topic')
            $state.goBack()
        , (error) ->
            alertsServ.error(error)


topicsServ.$inject = ['$meteor', '$state', 'alertsServ']

angular.module 'topics'
.service 'topicsServ', topicsServ
