angular.module 'posts', ['ui.router']

.config ($stateProvider) ->

  $stateProvider.state 'posts',
    url: '/posts'
    templateUrl: 'client/posts/posts-list.html'
    controller: 'PostCtrl'
    controllerAs: 'postCtrl'
