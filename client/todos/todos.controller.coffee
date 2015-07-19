Tasks = new Mongo.Collection("tasks")

angular.module('todos')
.controller 'TodosListCtrl', ($scope, $meteor) ->
  $scope.tasks = $meteor.collection( ->
    Tasks.find $scope.getReactively('query'), sort: createdAt: -1
  )

  $scope.incompleteCount = ->
    Tasks.find(checked: $ne: true).count()

  $scope.addTask = (newTask) ->
    $meteor.call 'addTask', newTask

  $scope.deleteTask = (task) ->
    $meteor.call 'deleteTask', task._id

  $scope.setChecked = (task) ->
    $meteor.call 'setChecked', task._id, !task.checked

  $scope.$watch 'hideCompleted', ->
    if $scope.hideCompleted
      $scope.query = checked: $ne: true
    else
      $scope.query = {}
