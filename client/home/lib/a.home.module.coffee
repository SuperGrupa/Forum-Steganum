homeModule = ($stateProvider) ->
  $stateProvider.state 'home',
    parent: 'root.main'
    url: '/'
    templateUrl: 'client/home/home.html'
  return


homeModule.$inject = ['$stateProvider']

angular.module 'home', ['ui.router']
.config homeModule
