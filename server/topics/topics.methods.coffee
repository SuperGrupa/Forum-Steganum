Meteor.methods
    addTopic: (topic) ->
        if !Meteor.userId()
            throw new (Meteor.Error)('not-authorized')

        Topics.insert
            id: incrementCounter(Counters, 'topic_id').toString()
            section_id: topic.section_id
            name: topic.name
            description: topic.description
            createdAt: new Date
            updatedAt: new Date
            userId: Meteor.userId()

    updateTopic: (topic) ->
        # TODO autoryzacja czy jest adminem...
        Topics.update { id: topic.id },
            $set:
                name: topic.name
                description: topic.description
                updatedAt: new Date

    deleteTopic: (topic_id) ->
        # TODO autoryzacja czy jest adminem ...
        Topics.remove { id: topic_id }
        # usuń również posty z tego tematu
        Posts.remove { topic_id: topic_id }

    getTopicById: (topic_id) ->
        Topics.findOne({ id: topic_id })
