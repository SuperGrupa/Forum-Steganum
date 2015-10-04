angular.module('sections')
.controller 'SectionsCtrl', (sectionsServ) ->
    vm = this
    vm.section = sectionsServ
    return vm
