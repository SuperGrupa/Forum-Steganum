isAdmin = ->
    'isAdmin': ['authServ', (authServ) ->
        authServ.hasRole('admin')]

adminModule = ($stateProvider) ->
  $stateProvider.state 'admin',
    parent: 'root.main'
    url: '/admin'
    templateUrl: 'client/admin/admin.html'
    controller: 'adminCtrl as adminVM'
    resolve: isAdmin()

  return


adminModule.$inject = ['$stateProvider']

angular.module 'admin', ['ui.router']
.config adminModule
