angular.module('topics')
.controller 'DeleteTopicCtrl', (topicsServ, $state, $stateParams) ->
    vm = this
    vm.state = $state
    vm.topic =
        id: $stateParams.topic_id
        section_id: $stateParams.section_id

    topicsServ.getTopicById(vm.topic.id).then (result) ->
        vm.topic.name = result.name

    return vm
