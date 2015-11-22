postsServ = ($meteor) ->
    add: (newPost, imagesFilesList) ->
        unless _.isEmpty imagesFilesList
            image = Images.insert _.first(imagesFilesList), (error, fileObj) ->
                if (error)
                    console.log error

        newPost.image_id = image._id if image?
        $meteor.call 'addPost', newPost
    delete: (post) ->
        $meteor.call 'deletePost', post.id
    update: (post) ->
        $meteor.call 'updatePost', post.id, post.text
    findOwner: (post) ->
        $meteor.object(Meteor.users, post.userId, false).subscribe('usersBasicInfo')

postsServ.$inject = ['$meteor']

angular.module 'posts'
.service 'postsServ', postsServ
