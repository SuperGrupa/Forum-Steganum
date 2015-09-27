Sections = new Mongo.Collection("sections")

if Sections.find().count() == 0
    sections = [
          name: 'Topic no 1'
          description: 'Description no 1'
        ,
          name: 'Topic no 2'
          description: 'Description no 2'
        ,
          name: 'Topic no 3'
          description: 'Description no 3'
    ]

    Sections.insert section for section in sections

Meteor.publish 'sections', ->
    Sections.find {},
        sort: createdAt: -1
