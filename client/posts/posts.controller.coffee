Posts = new Mongo.Collection("posts")

angular.module('posts')
.controller 'PostsListCtrl', ($scope, $meteor) ->
  $scope.posts = $meteor.collection(Posts).subscribe('posts')

  $scope.addPost = (newPost) ->
    $meteor.call 'addPost', newPost

  $scope.deletePost = (post) ->
    $meteor.call 'deletePost', post._id

  $scope.updatePost = (post) ->
    $meteor.call 'updatePost', post._id, post.text
