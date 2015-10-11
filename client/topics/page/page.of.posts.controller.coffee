angular.module('topics')
.controller 'PageOfPostsCtrl', (topicsServ, $stateParams) ->
    vm = this
    vm.page_number = $stateParams.page_number
    vm.topic =
        id: $stateParams.topic_id
        section_id: $stateParams.section_id

    vm.topic.posts = topicsServ.getPostsByTopicId(vm.topic.id, vm.page_number, 10)

    return vm
