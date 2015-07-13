Tasks = new Mongo.Collection("tasks")

if Meteor.isClient
  # This code only runs on the client
  angular.module 'simple-todos', [ 'angular-meteor' ]
  angular.module('simple-todos').controller 'TodosListCtrl', [
    '$scope', '$meteor'
    ($scope, $meteor) ->
      $scope.tasks = $meteor.collection(Tasks)
  ]
if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup
