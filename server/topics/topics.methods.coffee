Meteor.methods
    addTopic: (topic) ->
        if !Meteor.userId()
            throw new (Meteor.Error)('not-authorized')

        id = Topics.insert
            section_id: topic.section_id
            name: topic.name
            description: topic.description
            createdAt: new Date
            updatedAt: new Date
            userId: Meteor.userId()

    updateTopic: (topic) ->
        Topics.update { _id: topic._id },
            $set:
                name: topic.name
                description: topic.description

    deleteTopic: (topic_id) ->
        # autoryzacja czy jest adminem ...
        Topics.remove
            _id: topic_id

    getTopicsOfSection: (section_id) ->
        Topics.find({ section_id: section_id }).fetch()

    getTopicById: (topic_id) ->
        Topics.findOne({ _id: topic_id })

Meteor.publish 'topics', ->
    Topics.find {},
        sort: createdAt: -1

Meteor.publish 'topicsByIds', (topic_ids) ->
    Topics.find { _id: { $in: topic_ids } },
        sort: createdAt: -1