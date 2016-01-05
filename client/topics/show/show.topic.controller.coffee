ShowTopicCtrl = (topicsServ, $stateParams) ->
    vm = this
    vm.page_number = 0
    vm.topic =
        id: $stateParams.topic_id
        section_id: $stateParams.section_id


    do vm.loadMorePosts = () ->
        vm.page_number += 1
        console.log vm.page_number
        [vm.topic.images, vm.topic.posts] = topicsServ.getPostsWithImages(vm.topic.id, vm.page_number, 10)

    return vm


ShowTopicCtrl.$inject = ['topicsServ', '$stateParams']

angular.module('topics')
.controller 'ShowTopicCtrl', ShowTopicCtrl
