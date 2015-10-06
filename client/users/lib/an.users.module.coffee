angular.module 'users', ['ui.router']

.config ($stateProvider) ->

  $stateProvider
  .state 'users',
    parent: 'root.main'
    abstract: true
    url: '/users'
    controller: 'UserCtrl'
    controllerAs: 'userCtrl'
    templateUrl: 'client/users/users.html'

  .state 'login',
    parent: 'users'
    url: '/login'
    controller: 'LoginCtrl'
    controllerAs: 'logCtrl'
    templateUrl: 'client/users/login/login.html'

  .state 'register',
    parent: 'users'
    url: '/register'
    controller: 'NewUserCtrl'
    controllerAs: 'nUCtrl'
    templateUrl: 'client/users/new/new.user.html'
