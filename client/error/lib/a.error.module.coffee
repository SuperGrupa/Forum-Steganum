homeModule = ($stateProvider) ->
  $stateProvider.state 'error',
    parent: 'root.main'
    url: '/error'
    templateUrl: 'client/error/error.html'
    controller: 'errorCtrl as errorVM'
    params:
      code: 0
      text: ''
  return


homeModule.$inject = ['$stateProvider']

angular.module 'error', ['ui.router']
.config homeModule
