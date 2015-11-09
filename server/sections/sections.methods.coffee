Meteor.methods
    getSectionById: (section_id) ->
        Sections.findOne { id: section_id }
    deleteSection: (section_id) ->
        # TODO sprawdzenie uprawnień ...

        # wyznacz id tematów w danym dziale (sekcji) forum
        topics_in_section = Topics.find(section_id: section_id, { fields: { id: 1 } }).fetch()
        topic_ids_in_section = (topic.id for topic in topics_in_section)

        # usuń posty z tych tematów, tematy i sam dział (sekcję)
        Posts.remove { topic_id: { $in: topic_ids_in_section } }
        Topics.remove { section_id: section_id }
        Sections.remove { id: section_id }
    updateSection: (section) ->
        # TODO sprawdzenie uprawnień ...

        Sections.update { id: section.id },
            $set:
                name: section.name
                description: section.description
