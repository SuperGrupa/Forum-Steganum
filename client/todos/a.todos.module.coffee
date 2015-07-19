angular.module 'todos', ['ui.router']

.config ($stateProvider) ->

  $stateProvider.state 'todos',
    url: '/todos'
    templateUrl: 'client/todos/todos-list.html'
    controller: 'TodosListCtrl'
