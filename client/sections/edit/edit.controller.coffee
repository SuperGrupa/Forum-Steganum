editSectionController = (sectionsServ, $state, $stateParams) ->
    vm = this
    vm.state = $state
    vm.section = {}

    sectionsServ.getSectionById($stateParams.section_id).then (result) ->
        if _.isString(result)
            eval(result)
        else
            vm.section = result

    return vm

editSectionController.$inject = ['sectionsServ', '$state', '$stateParams']

angular.module('sections')
.controller 'EditSectionCtrl', editSectionController
