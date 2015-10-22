angular.module('sections')
.controller 'DeleteSectionCtrl', (sectionsServ, $state, $stateParams) ->
    vm = this
    vm.state = $state
    vm.section =
        id: $stateParams.section_id

    sectionsServ.getSectionById(vm.section.id).then (result) ->
        vm.section.name = result.name

    return vm
