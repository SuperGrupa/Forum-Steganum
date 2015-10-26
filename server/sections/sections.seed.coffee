Meteor.methods
    seedSections: ->
        # usuń wszystkie sekcje (działy) na forum
        Sections.remove {}

        # sections = ({
        #     _id: num.toString()
        #     name: 'Section no ' + num
        #     description: 'Description of section no. ' + num
        # } for num in [1..6])

        sections = [
          {
            _id: '1'
            name: 'Cats'
            description: 'Section about cats.'
          }
          {
            _id: '2'
            name: 'Dogs'
            description: 'Section about dogs.'
          }
          {
            _id: '3'
            name: 'HydePark'
            description: 'Section about everything.'
          }
        ]

        Sections.insert section for section in sections
