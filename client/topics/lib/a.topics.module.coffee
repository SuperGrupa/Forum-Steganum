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
    ).state('topic.posts',
        url: '/:topic_id/page/:page_number'
        templateUrl: 'client/topics/page/page.of.posts.html'
        controller: 'PageOfPostsCtrl'
        controllerAs: 'page'
    ).state('topic.edit',
        url: '/:topic_id/edit'
        templateUrl: 'client/topics/edit/edit.topic.html'
    ).state('topic.delete',
        url: '/:topic_id/delete'
        templateUrl: 'client/topics/delete/delete.topic.html'
        controller: 'DeleteTopicCtrl'
        controllerAs: 'deleteTopicCtrl'
    )
