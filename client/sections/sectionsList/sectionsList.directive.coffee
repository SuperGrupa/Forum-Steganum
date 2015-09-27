angular.module 'sections'
.directive 'sectionsList', ->
    restrict: 'AE'
    replace: true
    scope: true
    bindToController:
        sections: '='
    templateUrl: 'client/sections/sectionsList/sectionsList.directive.html'
    controllerAs: 'listDir'
    controller: () ->
        vm = this
        return vm
