angular.module('topics')
.controller 'NewTopicCtrl', (topicsServ, $stateParams) ->
    vm = this
    vm.section =
        id: $stateParams.id
        name: topicsServ.getSectionTitle(this.id)

    return vm
