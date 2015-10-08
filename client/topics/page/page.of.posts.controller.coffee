angular.module('topics')
.controller 'PageOfPostsCtrl', (topicsServ, $meteor, $stateParams) ->
    vm = this
    vm.page_number = $stateParams.page_number
    vm.topic =
        id: $stateParams.topic_id
        section_id: $stateParams.section_id

    topicsServ.getPostsByTopicId(vm.topic.id, vm.page_number, 10).then (result) ->
        vm.topic.posts = result

    return vm
