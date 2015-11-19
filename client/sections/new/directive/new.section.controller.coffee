newSectionController = () ->
    vm = this

    vm.section =
        name: ''

    return vm

angular.module('sections')
.controller 'newSectionCtrl', newSectionController
