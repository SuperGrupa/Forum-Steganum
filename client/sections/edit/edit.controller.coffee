angular.module('sections')
.controller 'EditSectionCtrl', (sectionsServ, $state, $stateParams) ->
    vm = this
    vm.state = $state
    vm.section = {}

    sectionsServ.getSectionById($stateParams.section_id).then (result) ->
        vm.section = result

    return vm
