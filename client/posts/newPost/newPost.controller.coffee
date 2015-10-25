newPostController = (postsServ, $stateParams) ->
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

newPostController.$inject = ['postsServ', '$stateParams']

angular.module('posts')
.controller 'newPostController', newPostController
