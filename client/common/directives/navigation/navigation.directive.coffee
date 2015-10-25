navigation = ->
    restrict: 'AE'
    scope:
        sectionId: '@'
        topicId: '@'
    bindToController: true
    templateUrl: 'client/common/directives/navigation/navigation.directive.html'
    controllerAs: 'nav'
    controller: 'navigationController'

angular.module 'common'
.directive 'navigation', navigation
