postsList = ->
    restrict: 'AE'
    scope: true
    bindToController:
        posts: '='
    templateUrl: 'client/posts/postsList/postsList.directive.html'
    controllerAs: 'listDir'
    controller: (postsServ) ->
        vm = this
        vm.post = postsServ
        return vm


angular.module 'posts'
.directive 'postsList', postsList
