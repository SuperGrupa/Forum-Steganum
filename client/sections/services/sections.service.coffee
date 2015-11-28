sectionsServ = ($meteor, $state, alertsServ) ->
    all: $meteor.collection(Sections).subscribe('sections')

    create: (section) ->
        $meteor.call('addSection', section).then ->
            alertsServ.success('New Section', 'You\'ve created a section')
            $state.go('section.list')
        , (error) ->
            alertsServ.error(error)

    getTopics: (section_id) ->
        $meteor.collection ->
            Filter.Topics.by.section(section_id)
        .subscribe('topicsInSection', section_id)

    getSectionById: (section_id) ->
        $meteor.call 'getSectionById', section_id

    update: (section) ->
        $meteor.call('updateSection', section).then ->
            alertsServ.success('Update Section', 'You\'ve updated a section')
            $state.goBack()
        , (error) ->
            alertsServ.error(error)

    delete: (section_id) ->
        $meteor.call('deleteSection', section_id).then ->
            alertsServ.success('Remove Secion', 'You\'ve removed a section')
            $state.goBack()
        , (error) ->
            alertsServ.error(error)


sectionsServ.$inject = ['$meteor', '$state', 'alertsServ']

angular.module 'sections'
.service 'sectionsServ', sectionsServ
