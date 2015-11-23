newPostController = (postsServ, $stateParams) ->
    vm = this
    vm.action = postsServ
    vm.images = []

    do vm.clearPost = () ->
        vm.post =
            text: ''
            topic_id: $stateParams.topic_id
        vm.images = []

    vm.addPost = () ->
        unless _.isEmpty(vm.images) && vm.post.text == ''
            vm.action.add(vm.post, vm.images).then ->
                vm.clearPost()
        else
            alert 'Empty posts are not allowed on this forum!'

    return vm

newPostController.$inject = ['postsServ', '$stateParams']

angular.module('posts')
.controller 'newPostController', newPostController
