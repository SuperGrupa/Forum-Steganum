newSectionController = (sectionsServ) ->
    vm = this

    vm.section =
        name: ''

    return vm

newSectionController.$inject = ['sectionsServ']

angular.module('sections')
.controller 'newSectionCtrl', newSectionController
