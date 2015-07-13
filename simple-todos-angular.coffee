Tasks = new Mongo.Collection("tasks")

if Meteor.isClient
  # This code only runs on the client
  angular.module 'simple-todos', [ 'angular-meteor' ]
  angular.module('simple-todos').controller 'TodosListCtrl', [
    '$scope', '$meteor'
    ($scope, $meteor) ->
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
  ]

  Accounts.ui.config({
    passwordSignupFields: "USERNAME_ONLY"
  })
if Meteor.isServer
  Meteor.startup ->
    # code to run on server at startup


Meteor.methods
  addTask: (text) ->
    # Make sure the user is logged in before inserting a task
    if !Meteor.userId()
      throw new (Meteor.Error)('not-authorized')
    Tasks.insert
      text: text
      createdAt: new Date
      owner: Meteor.userId()
      username: Meteor.user().username
  deleteTask: (taskId) ->
    Tasks.remove taskId
  setChecked: (taskId, setChecked) ->
    Tasks.update taskId, $set: checked: setChecked
