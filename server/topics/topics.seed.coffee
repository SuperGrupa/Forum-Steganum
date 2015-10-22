Meteor.methods
    seedTopics: ->
        # usuń wszystkie tematy
        Topics.remove {}

        topics = ({
            _id: num.toString()
            section_id: num.toString()
            name: 'Topic no ' + num
            description: 'Description of topic no ' + num
        } for num in [1..6])

        Topics.insert topic for topic in topics
