newSection = ->
    restrict: 'AE'
    scope: true
    bindToController: true
    templateUrl: 'client/sections/new/directive/new.section.directive.html'
    controllerAs: 'new'
    controller: 'newSectionCtrl'

angular.module 'sections'
.directive 'newSection', newSection
