angular.module 'common'
.directive 'showMessage', ->
  restrict: 'AE'
  scope:
    message: '='
    type: '@'
  bindToController: true
  templateUrl: 'client/common/directives/showMessage/showMessage.directive.html'
  controllerAs: 'vm'
  controller: () ->
    vm = this
    return vm

