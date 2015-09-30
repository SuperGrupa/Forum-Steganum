Topics = new Mongo.Collection("topics")

do ->
    if Topics.find().count() == 0
        topics = ({
            _id: num.toString()
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
