authButtons = ->
  restrict: 'AE'
  scope:
    login: '='
  bindToController: true
  templateUrl: 'client/users/directives/authButtons/authButtons.directive.html'
  controllerAs: 'vm'
  controller: () ->
    vm = this
    return vm

angular.module 'users'
.directive 'authButtons', authButtons

