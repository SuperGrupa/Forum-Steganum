Topics = new Mongo.Collection('topics')

angular.module 'topics'
.service 'topicsServ', ($meteor, $state) ->
    getSectionTitle: (section_id) ->
        $meteor.call 'sectionTitleById', section_id
    getPostsByTopicId: (topic_id, page_number, posts_per_page) ->
        $meteor.call 'getPostsByTopicId', topic_id, page_number, posts_per_page
    getTopicById: (topic_id) ->
        $meteor.call 'getTopicById', topic_id
    create: (topic, section_id) ->
        $meteor.call('addTopic', topic).then ->
            $state.go('section.one.show', id: section_id)
    update: (topic) ->
        $meteor.call('updateTopic', topic).then ->
            $state.go('section.one.show', id: topic.section_id)
    delete: (topic_id) ->
        $meteor.call('deleteTopic', topic_id).then ->
            if $state.previous.name then $state.go($state.previous) else $state.go('home')
