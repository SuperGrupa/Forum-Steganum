isAdmin = ->
    'isAdmin': ['authServ', (authServ) ->
        authServ.hasRole('admin')]

adminModule = ($stateProvider) ->
  $stateProvider
  .state 'admin',
    abstract: true
    parent: 'root.main'
    url: '/admin'
    templateUrl: 'client/admin/admin.html'
    controller: 'adminCtrl as adminVM'
    resolve: isAdmin()
  .state 'admin.main',
    url: ''
    templateUrl: 'client/admin/main/main.html'
    controller: 'mainACtrl as mainA'
  .state 'admin.users',
    url: '/users'
    templateUrl: 'client/admin/users/users.html'
    controller: 'usersACtrl as usersA'
  .state 'admin.roles',
    url: '/roles'
    templateUrl: 'client/admin/roles/roles.html'
    controller: 'rolesACtrl as rolesA'

  return


adminModule.$inject = ['$stateProvider']

angular.module 'admin', ['ui.router']
.config adminModule
