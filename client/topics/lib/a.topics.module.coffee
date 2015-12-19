resolveObject = (what, name) ->
    'isLogged': ['authServ', (authServ) ->
        authServ.isLogged()]
    'userCan': ['authServ', (authServ) ->
        authServ.stateCan(what, name)]

topicsModule = ($stateProvider) ->
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
        resolve: resolveObject('create', 'topic')
    ).state('topic.posts',
        url: '/:topic_id/page/:page_number'
        templateUrl: 'client/topics/page/page.of.posts.html'
        controller: 'PageOfPostsCtrl'
        controllerAs: 'page'
        resolve: resolveObject('read', 'topic')
    ).state('topic.edit',
        url: '/:topic_id/edit'
        templateUrl: 'client/topics/edit/edit.topic.html'
        resolve: resolveObject('update', 'topic')
    ).state('topic.delete',
        url: '/:topic_id/delete'
        templateUrl: 'client/topics/delete/delete.topic.html'
        controller: 'DeleteTopicCtrl'
        controllerAs: 'deleteTopicCtrl'
        resolve: resolveObject('remove', 'topic')
    )
    return

topicsModule.$inject = ['$stateProvider']

angular.module 'topics', ['ui.router']
.config topicsModule
