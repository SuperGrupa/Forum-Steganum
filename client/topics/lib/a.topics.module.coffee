angular.module 'topics', ['ui.router']

.config ($stateProvider) ->
    $stateProvider.state('topic',
        url: '/topic'
        parent: 'section.show'
        abstract: true
    ).state('topic.list',
        url: 's'
    ).state('topic.new',
        url: '/new'
    ).state('topic.posts'
        url: '/:id/page/:page_id'
    ).state('topic.delete',
        url: '/:id/delete'
    )
