Meteor.methods
    seedTopics: ->
        # usuń wszystkie tematy
        Topics.remove {}

        # topics = ({
        #     _id: num.toString()
        #     section_id: (num % 6 + 1).toString()
        #     name: 'Topic no ' + num
        #     description: 'Description of topic no ' + num
        # } for num in [1..18])

        topics = [
          {
            _id: '1'
            section_id: '2'
            name: 'I was bitten by my dog?'
            description: 'It did not bleed but it turn into bruises.'
          }
          {
            _id: '2'
            section_id: '2'
            name: ' Is caging dogs a good idea...'
            description: 'Hi guys I have two pets and my mom cage them is this alright?'
          }
          {
            _id: '3'
            section_id: '2'
            name: 'Keeping children safe with dogs'
            description: '77% of dog bites come from the family dog, or a friends dog.'
          }
          {
            _id: '4'
            section_id: '1'
            name: 'My kitten - request for advice'
            description: 'A few days ago I bought a kitten...'
          }
          {
            _id: '5'
            section_id: '1'
            name: 'Stray kittens'
            description: 'There is a stray cat whos had kittens in my next door neighbours shed'
          }
          {
            _id: '6'
            section_id: '1'
            name: 'My cat broke his leg, Please help!'
            description: 'Long story short my cat broke his leg '
          }
        ]

        Topics.insert topic for topic in topics
