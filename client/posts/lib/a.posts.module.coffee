angular.module 'posts', ['ui.router']

.config ($stateProvider) ->

  $stateProvider.state 'posts',
    parent: 'root.main'
    url: '/posts'
    templateUrl: 'client/posts/posts-list.html'
    controller: 'PostCtrl'
    controllerAs: 'postCtrl'
