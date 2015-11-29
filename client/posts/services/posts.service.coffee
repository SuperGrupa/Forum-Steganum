postsServ = ($meteor) ->
    add: (newPost, image) ->
        unless image.name == ''
            image = Images.insert image, (error, fileObj) ->
                if (error)
                    alert error

            # nie udało się przesłać pliku - nie wysyłaj samej treści
            unless image? && image._id?
                return

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
