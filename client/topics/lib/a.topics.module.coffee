angular.module 'topics', ['ui.router']

.config ($stateProvider) ->
    $stateProvider.state('topic',
        url: '/topic'
        parent: 'section.one'
        templateUrl: 'client/topics/topics.html'
        controller: 'TopicsCtrl'
        controllerAs: 'topicsCtrl'
        abstract: true
    ).state('topic.new',
        url: '/new'
        templateUrl: 'client/topics/new/new.topic.html'
    ).state('topic.posts'
        url: '/:id/page/:page_id'
    ).state('topic.delete',
        url: '/:id/delete'
    )
