# Angular modules
angular.module 'angular-meteor', []
angular.module 'toastr', []

# Meteor.users
Meteor = () ->
    this.users = { }

# Mongo collections
Sections = { }
Images =
    insert: () -> _id: 'abc'
    findOne: () -> angular.noop

