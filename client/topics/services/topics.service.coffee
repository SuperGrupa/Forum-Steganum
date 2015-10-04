Topics = new Mongo.Collection('topics')

angular.module 'topics'
.service 'topicsServ', ($meteor, $state) ->
    getSectionTitle: (section_id) ->
        $meteor.call 'sectionTitleById', section_id
    create: (topic, section_id) ->
        $meteor.call('addTopic', topic).then ->
            $state.go('section.one.show', id: section_id)
    delete: (topic_id) ->
        $meteor.call('deleteTopic', topic_id).then ->
            if $state.previous.name then $state.go($state.previous) else $state.go('home')
