@Filter =
    Posts:
        by: (topic_id, page_number, posts_per_page) ->
            Posts.find topic_id: topic_id,
                sort: createdAt: 1
                skip: (page_number - 1) * posts_per_page
                limit: posts_per_page
    Topics:
        by:
            section: (section_id) ->
                Topics.find { section_id: section_id }, sort: createdAt: -1
            id: (topic_id) ->
                Topics.findOne { id: topic_id }
    Sections:
        by: (section_id) ->
            Sections.findOne { id: section_id }
