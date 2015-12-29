newPostController = (postsServ, alertsServ, $stateParams, $timeout) ->
    vm = this
    vm.action = postsServ
    vm.image =
        name: ''

    do vm.clearPost = () ->
        vm.post =
            text: ''
            topic_id: $stateParams.topic_id
        vm.image =
            name: ''

    vm.addPost = (post, image) ->
        unless image.name == '' && post.text == ''
            vm.action.add(post, image).then ->
                vm.clearPost()
        else
            alertsServ.error(error: 'emptyPostNotAllowed')
    
    $timeout ->
        if stegano?
            stegano.module('integration').run()

    return vm

newPostController.$inject = ['postsServ', 'alertsServ', '$stateParams', '$timeout']

angular.module('posts')
.controller 'newPostController', newPostController

