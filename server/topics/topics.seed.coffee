Meteor.methods
    seedTopics: ->
        # usuń wszystkie tematy
        Topics.remove {}

        topics = ({
            _id: num.toString()
            section_id: (num % 6 + 1).toString()
            name: 'Topic no ' + num
            description: 'Description of topic no ' + num
        } for num in [1..18])

        Topics.insert topic for topic in topics
