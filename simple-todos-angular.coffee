Tasks = new Mongo.Collection("tasks")

if Meteor.isClient
  # This code only runs on the client
  angular.module 'simple-todos', [ 'angular-meteor' ]
  angular.module('simple-todos').controller 'TodosListCtrl', [
    '$scope', '$meteor'
    ($scope, $meteor) ->
      $scope.tasks = $meteor.collection( ->
        Tasks.find {}, sort: createdAt: -1
      )

      $scope.addTask = (newTask) ->
        $scope.tasks.push
          text: newTask
          createdAt: new Date
  ]
if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
