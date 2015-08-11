angular.module 'posts'
.directive 'postsList', ->
  restrict: 'AE'
  replace: true
  scope: true
  bindToController:
    posts: '='
  templateUrl: 'client/posts/postsList/postsList.directive.html'
  controllerAs: 'listDir'
  controller: () ->
    vm = this
    return vm
