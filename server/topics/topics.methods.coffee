auth = require('authFunctions')
Counters = require 'Counters'

Meteor.methods
    addTopic: (topic) ->
        if auth.can('create', 'topic', topic)
            Topics.insert
                id: incrementCounter(Counters, 'topic_id').toString()
                section_id: topic.section_id
                name: topic.name
                description: topic.description
                createdAt: new Date
                updatedAt: new Date
                userId: Meteor.userId()

    updateTopic: (topic) ->
        if auth.can('update', 'topic', topic)
            Topics.update { id: topic.id },
                $set:
                    name: topic.name
                    description: topic.description
                    updatedAt: new Date

    deleteTopic: (topic_id) ->
        if auth.can('remove', 'topic', topic_id)

            Topics.remove { id: topic_id }
            # usuń również posty z tego tematu
            Posts.remove { topic_id: topic_id }

    getTopicById: (topic_id) ->
        if auth.can('read', 'topic', topic_id)
            Topics.findOne({ id: topic_id })
