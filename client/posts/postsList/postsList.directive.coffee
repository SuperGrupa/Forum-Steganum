angular.module 'posts'
.directive 'postsList', ->
  restrict: 'AE'
  scope: true
  bindToController:
    posts: '='
  templateUrl: 'client/posts/postsList/postsList.directive.html'
  controllerAs: 'listDir'
  controller: () ->
    vm = this
    return vm
