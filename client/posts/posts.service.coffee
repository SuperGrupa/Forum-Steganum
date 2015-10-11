angular.module 'posts'
.service 'postsServ', ($meteor) ->
    add: (newPost) ->
        $meteor.call 'addPost', newPost
    delete: (post) ->
        $meteor.call 'deletePost', post._id
    update: (post) ->
        $meteor.call 'updatePost', post._id, post.text
    findOwner: (post) ->
        Meteor.users.findOne(post.userId)
