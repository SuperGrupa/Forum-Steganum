Meteor.methods
    getSectionById: (section_id) ->
        Sections.findOne { _id: section_id }
    deleteSection: (section_id) ->
        # sprawdzenie uprawnień ...

        # wyznacz id tematów w danym dziale (sekcji) forum
        topics_in_section = Topics.find(section_id: section_id, { fields: { _id: 1 } }).fetch()
        topic_ids_in_section = (topic.id for topic in topics_in_section)

        # usuń posty z tych tematów, tematy i sam dział (sekcję)
        Posts.remove { topic_id: { $in: topic_ids_in_section } }
        Topics.remove { section_id: section_id }
        Sections.remove { _id: section_id }
    updateSection: (section) ->
        # sprawdzenie uprawnień ...

        Sections.update { _id: section._id },
            $set:
                name: section.name
                description: section.description
