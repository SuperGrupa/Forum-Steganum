sectionsServ = ($meteor, $state) ->
    all: $meteor.collection(Sections).subscribe('sections')

    getTopics: (section_id) ->
        $meteor.collection ->
            Topics.find({ section_id: section_id })
        .subscribe('topicsInSection', section_id)

    getSectionById: (section_id) ->
        $meteor.call 'getSectionById', section_id

    update: (section) ->
        $meteor.call('updateSection', section).then ->
            $state.goBack()

    delete: (section_id) ->
        $meteor.call('deleteSection', section_id).then ->
            $state.goBack()


sectionsServ.$inject = ['$meteor', '$state']

angular.module 'sections'
.service 'sectionsServ', sectionsServ
