liveEdit = ->
    restrict: 'AE'
    replace: true
    scope: true
    bindToController:
        object: '='
        onSave: '&'
        inputType: '@'
    templateUrl: 'client/common/directives/liveEdit/liveEdit.directive.html'
    controllerAs: 'live'
    controller: 'liveEditController'

angular.module 'common'
.directive 'liveEdit', liveEdit
