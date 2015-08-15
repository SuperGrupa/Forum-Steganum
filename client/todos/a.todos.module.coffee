angular.module 'todos', ['ui.router']

.config ($stateProvider) ->

  $stateProvider.state 'todos',
    parent: 'root.main'
    url: '/todos'
    templateUrl: 'client/todos/todos-list.html'
    controller: 'TodosListCtrl'
