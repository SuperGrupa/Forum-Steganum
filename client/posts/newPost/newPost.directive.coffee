angular.module 'posts'
.directive 'newPost', ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/posts/newPost/newPost.directive.html'
    controllerAs: 'new'
    controller: (postsServ, $stateParams) ->
        vm = this
        vm.action = postsServ
        vm.post =
            text: ''
            topic_id: $stateParams.topic_id

        return vm
