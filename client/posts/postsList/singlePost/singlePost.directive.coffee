singlePost = ->
    restrict: 'AE'
    scope: true
    bindToController:
        post: '@'
    templateUrl: 'client/posts/postsList/singlePost/singlePost.directive.html'
    controllerAs: 'singleDir'
    controller: () ->
        vm = this
        return vm


angular.module 'posts'
.directive 'singlePost', singlePost
