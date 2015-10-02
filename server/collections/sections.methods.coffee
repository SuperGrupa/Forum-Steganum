Sections = new Mongo.Collection("sections")

do ->
    if Sections.find().count() == 0
        sections = [
              _id: '1'
              name: 'Section no 1'
              description: 'Description no 1'
              topic_ids: ['1']
            ,
              _id: '2'
              name: 'Section no 2'
              description: 'Description no 2'
              topic_ids: ['2', '3', '5']
            ,
              _id: '3'
              name: 'Section no 3'
              description: 'Description no 3'
              topic_ids: ['4', '6']
        ]

        Sections.insert section for section in sections

    Meteor.publish 'sections', ->
        Sections.find {},
            sort: createdAt: -1

    Meteor.publish 'sectionTopicIds', (section_id) ->
        Sections.find { _id: section_id },
            fields: { 'topic_ids': 1 }

    Meteor.publish 'sectionName', (section_id) ->
        Sections.find { _id: section_id },
            fields { 'name': 1 }
