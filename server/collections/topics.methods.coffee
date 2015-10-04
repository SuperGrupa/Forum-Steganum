Topics = new Mongo.Collection("topics")

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

    deleteTopic: (topic_id) ->
        # autoryzacja czy jest adminem ...
        Topics.remove
            _id: topic_id

    getTopicsOfSection: (section_id) ->
        Topics.find({ section_id: section_id }).fetch()

do ->
    if Topics.find().count() == 0
        topics = ({
            _id: num.toString()
            section_id: num.toString()
            name: 'Topic no ' + num
            description: 'Description of topic no ' + num
        } for num in [1..6])

        Topics.insert topic for topic in topics

    Meteor.publish 'topics', ->
        Topics.find {},
            sort: createdAt: -1

    Meteor.publish 'topicsByIds', (topic_ids) ->
        Topics.find { _id: { $in: topic_ids } },
            sort: createdAt: -1
