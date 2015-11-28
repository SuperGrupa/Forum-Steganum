errorCtrl = ($stateParams) ->
  this.params = $stateParams

  return this

errorCtrl.$inject = ['$stateParams']

angular.module('error')
.controller 'errorCtrl', errorCtrl
