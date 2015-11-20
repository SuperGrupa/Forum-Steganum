newSectionController = () ->
    vm = this
    vm.section = { }
    return vm

angular.module('sections')
.controller 'newSectionCtrl', newSectionController
