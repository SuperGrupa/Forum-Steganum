Tasks = new Mongo.Collection("tasks")

angular.module('todos')
.controller 'TodosListCtrl', ($scope, $meteor) ->
  $scope.tasks = $meteor.collection(Tasks).subscribe('tasks')

  $scope.incompleteCount = ->
    Tasks.find(checked: $ne: true).count()

  $scope.addTask = (newTask) ->
    $meteor.call 'addTask', newTask

  $scope.deleteTask = (task) ->
    $meteor.call 'deleteTask', task._id

  $scope.setChecked = (task) ->
    $meteor.call 'setChecked', task._id, !task.checked
