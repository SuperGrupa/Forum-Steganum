ShowTopicCtrl = (topicsServ, $stateParams) ->
    vm = this
    vm.page_number = 1
    vm.topic =
        id: $stateParams.topic_id
        section_id: $stateParams.section_id

    [vm.topic.images, vm.topic.posts] = topicsServ.getPostsWithImages(vm.topic.id, vm.page_number, 10)

    vm.loadMorePosts = () ->
        vm.page_number += 1
        console.log vm.page_number

    return vm


ShowTopicCtrl.$inject = ['topicsServ', '$stateParams']

angular.module('topics')
.controller 'ShowTopicCtrl', ShowTopicCtrl
