Meteor.methods
    getSectionById: (section_id) ->
        Sections.findOne { _id: section_id }
