ShowSectionCtrl = (sectionsServ, $stateParams) ->
    vm = this
    vm.id = $stateParams.section_id
    vm.section = sectionsServ
    vm.topics = sectionsServ.getTopics(vm.id)

    return vm

ShowSectionCtrl.$inject = ['sectionsServ', '$stateParams']

angular.module('sections')
.controller 'ShowSectionCtrl', ShowSectionCtrl
