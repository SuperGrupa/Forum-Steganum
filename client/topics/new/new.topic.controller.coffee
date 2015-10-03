angular.module('topics')
.controller 'NewTopicCtrl', (topicsServ, $stateParams) ->
    vm = this
    vm.section =
        id: $stateParams.id

    topicsServ.getSectionTitle(vm.section.id).then (result) ->
        vm.section.name = result

    return vm
