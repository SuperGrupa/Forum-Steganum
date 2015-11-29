singlePost = ->
    restrict: 'AE'
    scope: true
    bindToController:
        post: '='
    templateUrl: 'client/posts/postsList/singlePost/singlePost.directive.html'
    controllerAs: 'singleDir'
    controller: () ->
        vm = this
        vm.postImage = ->
            Images.findOne({ _id: vm.post.image_id }).url()

        return vm


angular.module 'posts'
.directive 'singlePost', singlePost
