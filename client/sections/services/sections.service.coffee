angular.module 'sections'
.service 'sectionsServ', ($meteor) ->
    all: $meteor.collection(Sections).subscribe('sections')

    getTopics: (section_id) ->
        $meteor.collection ->
            Topics.find({ section_id: section_id })
        .subscribe('topicsInSection', section_id)

    getSectionById: (section_id) ->
        $meteor.call 'getSectionById', section_id

    delete: (section_id) ->
        console.log section_id
        #$meteor.call 'deleteSection', section_id
