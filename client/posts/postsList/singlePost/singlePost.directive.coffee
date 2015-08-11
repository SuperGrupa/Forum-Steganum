angular.module 'posts'
.directive 'singlePost', ->
  restrict: 'AE'
  replace: true
  scope: true
  bindToController:
    post: '='
  templateUrl: 'client/posts/postsList/singlePost/singlePost.directive.html'
  controllerAs: 'singleDir'
  controller: () ->
    vm = this
    return vm
