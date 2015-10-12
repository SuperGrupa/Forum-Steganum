Meteor.publish 'sections', ->
    Sections.find {},
        sort: createdAt: -1
