Meteor.methods
    # ważna sprawa! metody Meteora nie mogą zwracać kursorów, trzeba fetchować
    sectionTitleById: (section_id) ->
        Sections.findOne({ _id: section_id }, fields: { 'name': 1 }).name

do ->
    if Sections.find().count() == 0
        sections = ({
            _id: num.toString()
            name: 'Section no ' + num
            description: 'Description of section no ' + num
        } for num in [1..6])

        Sections.insert section for section in sections

    Meteor.publish 'sections', ->
        Sections.find {},
            sort: createdAt: -1

    Meteor.publish 'sectionName', (section_id) ->
        Sections.find { _id: section_id },
            fields { 'name': 1 }
