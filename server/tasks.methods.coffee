Tasks = new Mongo.Collection("tasks")

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
