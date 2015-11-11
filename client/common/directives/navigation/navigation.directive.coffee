navigation = ->
    restrict: 'AE'
    scope: {}
    bindToController:
        sectionId: '@'
        topicId: '@'
    templateUrl: 'client/common/directives/navigation/navigation.directive.html'
    controllerAs: 'nav'
    controller: 'navigationController'

angular.module 'common'
.directive 'navigation', navigation
