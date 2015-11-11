appRoutes = ($urlRouterProvider, $stateProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $stateProvider
  .state 'root',
    url: ''
    abstract: true
    views:
      'header':
        templateUrl: 'client/header/header.html'
        controller: 'HeaderCtrl as headCtrl'
      'footer':
        templateUrl: 'client/footer/footer.html'
  .state 'root.main',
    views: 'main@':
      templateUrl: 'client/main.html'

  $urlRouterProvider.otherwise '/'
  return

appRoutes.$inject = ['$urlRouterProvider', '$stateProvider', '$locationProvider']

angular.module 'forumSteganum'
.config appRoutes
