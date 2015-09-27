angular.module 'posts'
.directive 'newPost', ->
  restrict: 'AE'
  scope: true
  bindToController: true
  templateUrl: 'client/posts/newPost/newPost.directive.html'
  controllerAs: 'new'
  controller: () ->
    vm = this
    return vm
