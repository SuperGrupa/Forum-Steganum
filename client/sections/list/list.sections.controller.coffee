angular.module('sections')
.controller 'ListSectionsCtrl', (sectionsServ) ->
    vm = this
    vm.section = sectionsServ
    return vm
