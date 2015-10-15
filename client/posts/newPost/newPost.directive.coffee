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

        do vm.clearPost = () ->
            vm.post =
                text: ''
                topic_id: $stateParams.topic_id

        vm.addPost = (post) ->
            vm.action.add(post).then ->
                vm.clearPost()

        return vm
