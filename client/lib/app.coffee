angular.module 'forumSteganum', [
  'angular-meteor'
  'ui.router'
  'ngMaterial'
  'todos'
  'posts'
 ]

.config ($urlRouterProvider, $stateProvider, $locationProvider) ->
  $locationProvider.html5Mode true

  $stateProvider
  .state 'root',
    url: ''
    abstract: true
    views:
      'header':
        templateUrl: 'client/header/header.html'
      'footer':
        templateUrl: 'client/footer/footer.html'
  .state 'root.main',
    views: 'main@':
      templateUrl: 'client/main.html'

  .state 'home',
    parent: 'root.main'
    url: '/'
    templateUrl: 'client/home/home.html'


  # $stateProvider.state 'home',
  #   url: '/'
  #   templateUrl: 'client/home.html'

  $urlRouterProvider.otherwise '/'
