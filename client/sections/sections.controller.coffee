angular.module('sections')
.controller 'SectionCtrl', (sectionsServ) ->
    vm = this
    vm.section = sectionsServ
    return vm
