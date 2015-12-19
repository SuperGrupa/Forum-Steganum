# Angular modules
angular.module 'angular-meteor', []
angular.module 'toastr', []

# Meteor.users
Meteor =
    users: {}

# Mongo collections
Roles = {}
Sections = { }
Images =
    insert: () -> _id: 'abc'
    findOne: () -> angular.noop

