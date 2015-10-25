newPost = ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/posts/newPost/newPost.directive.html'
    controllerAs: 'new'
    controller: 'newPostController'

angular.module 'posts'
.directive 'newPost', newPost
