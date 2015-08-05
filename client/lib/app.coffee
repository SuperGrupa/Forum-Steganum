angular.module 'forumSteganum', [
  'angular-meteor'
  'ui.router'
  'ngMaterial'
  'todos'
 ]

.config ($urlRouterProvider, $stateProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $stateProvider.state 'home',
    url: '/'
    templateUrl: 'client/home.html'

  $urlRouterProvider.otherwise '/'

