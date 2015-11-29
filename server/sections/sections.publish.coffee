auth = require('authFunctions')

Meteor.publish 'sections', ->
    Sections.find {},
        sort: createdAt: -1
