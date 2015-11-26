Meteor = () ->
    this.users = { }

Sections = { }

Images =
    insert: () -> _id: 'abc'

angular.module 'angular-meteor', []
angular.module 'toastr', []

Filter =
  Posts:
    by: angular.noop
  Topics:
    by:
      section: angular.noop
      id: angular.noop
  Sections:
    by: angular.noop

_ =
    isEmpty: angular.noop
    first: angular.noop
