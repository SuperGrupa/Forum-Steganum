Meteor.methods
    seedSections: ->
        # usuń wszystkie sekcje (działy) na forum
        Sections.remove {}

        sections = [
          {
            id: '1'
            name: 'Cats'
            description: 'Section about cats.'
          }
          {
            id: '2'
            name: 'Dogs'
            description: 'Section about dogs.'
          }
          {
            id: '3'
            name: 'HydePark'
            description: 'Section about everything.'
          }
        ]

        Sections.insert section for section in sections

        setCounter(Counters, 'section_id', sections.length)
