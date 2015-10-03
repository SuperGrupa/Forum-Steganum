angular.module 'posts'
.directive 'authButtons', ->
  restrict: 'AE'
  scope:
    login: '='
  bindToController: true
  templateUrl: 'client/users/directives/auth-buttons/auth-buttons.directive.html'
  controllerAs: 'vm'
  controller: () ->
    vm = this
    return vm

