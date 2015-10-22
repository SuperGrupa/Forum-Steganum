angular.module 'sections'
.service 'sectionsServ', ($meteor) ->
    all: $meteor.collection(Sections).subscribe('sections')

    getTopics: (section_id) ->
        $meteor.collection ->
            Filter.Topics.by(section_id)
        .subscribe('topicsInSection', section_id)

    getSectionById: (section_id) ->
        $meteor.call 'getSectionById', section_id
