angular.module('sections')
.controller 'ShowSectionCtrl', (sectionsServ, $stateParams) ->
    vm = this
    vm.id = $stateParams.section_id
    vm.section = sectionsServ

    vm.section.getTopics(vm.id).then (result) ->
        vm.topics = result

    return vm
