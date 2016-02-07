@Filter =
    Posts:
        by: (topic_id, options) ->
            Posts.find topic_id: topic_id, options
    Topics:
        by:
            section: (section_id) ->
                Topics.find { section_id: section_id }, sort: createdAt: -1
            id: (topic_id) ->
                Topics.findOne { id: topic_id }
    Sections:
        by: (section_id) ->
            Sections.findOne { id: section_id }
