Meteor.methods
    getSectionById: (section_id) ->
        Sections.findOne { _id: section_id }
    deleteSection: (section_id) ->
        # sprawdzenie uprawnień ...
        Sections.remove { _id: section_id }
