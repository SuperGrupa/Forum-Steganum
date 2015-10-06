angular.module('topics')
.controller 'PageOfPostsCtrl', (topicsServ, $stateParams) ->
    vm = this
    vm.page_number = $stateParams.page_number
    vm.topic =
        id: $stateParams.topic_id
        section_id: $stateParams.section_id

    topicsServ.getPostsByTopicId(vm.topic.id, vm.page_number, 2).then (result) ->
        vm.topic.posts = result
        console.log result

    return vm
