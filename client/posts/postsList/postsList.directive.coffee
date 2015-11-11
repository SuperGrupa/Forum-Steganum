postsList = ->
    restrict: 'AE'
    scope: true
    bindToController:
        posts: '='
    templateUrl: 'client/posts/postsList/postsList.directive.html'
    controllerAs: 'listDir'
    controller: 'postsListController'

angular.module 'posts'
.directive 'postsList', postsList
