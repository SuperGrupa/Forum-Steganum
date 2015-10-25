SectionCtrl = (sectionsServ) ->
    vm = this
    vm.section = sectionsServ
    return vm

SectionCtrl.$inject = ['sectionsServ']

angular.module('sections')
.controller 'SectionCtrl', SectionCtrl
