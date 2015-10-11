Meteor.publish 'sections', ->
    Sections.find {},
        sort: createdAt: -1

Meteor.publish 'sectionName', (section_id) ->
    Sections.find { _id: section_id },
        fields { 'name': 1 }
