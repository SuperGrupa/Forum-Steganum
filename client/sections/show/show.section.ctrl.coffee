angular.module('sections')
.controller 'ShowSectionCtrl', (sectionsServ, $stateParams) ->
    vm = this
    vm.section = sectionsServ
    vm.id = $stateParams.id

    vm.getTopics = ->
        vm.section.getTopics(vm.id)

    return vm
