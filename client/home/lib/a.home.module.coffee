angular.module 'home', ['ui.router']

.config ($stateProvider) ->

  $stateProvider.state 'home',
    parent: 'root.main'
    url: '/'
    templateUrl: 'client/home/home.html'
