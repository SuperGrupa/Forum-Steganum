Meteor.methods
    # ważna sprawa! metody Meteora nie mogą zwracać kursorów, trzeba fetchować
    sectionTitleById: (section_id) ->
        Sections.findOne({ _id: section_id }, fields: { 'name': 1 }).name

Meteor.publish 'sections', ->
    Sections.find {},
        sort: createdAt: -1

Meteor.publish 'sectionName', (section_id) ->
    Sections.find { _id: section_id },
        fields { 'name': 1 }
