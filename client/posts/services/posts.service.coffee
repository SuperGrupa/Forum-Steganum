postsServ = ($meteor, $q, alertsServ) ->
    add: (newPost, image) ->
        # funkcja dodająca treść posta (bez ew. obrazka)
        addPostText = ->
            $meteor.call('addPost', newPost).then () ->
                alertsServ.success('New Post', 'You\'ve created a new post')
            , (error) ->
                alertsServ.error(error)

        unless image.name == ''
            if stegano?
                # jeśli wykryto moduł steganograficzny to niech on zrobi co trzeba i wyśle obrazek
                stegano.module('events').sendMessage (image_id) ->
                    newPost.image_id = image_id
                    addPostText()
                return $q.defer().promise
            else
                image = Images.insert image, (error, fileobj) ->
                    if (error)
                        alertsServ.error(error)
                # nie udało się przesłać pliku - nie wysyłaj samej treści
                unless image? && image._id?
                    return

         newPost.image_id = image._id if image?
         addPostText()

    delete: (post) ->
      $meteor.call('deletePost', post.id).then () ->
          alertsServ.success('Remove Post', 'You\'ve removed a post')
      , (error) ->
          alertsServ.error(error)
    update: (post) ->
      $meteor.call('updatePost', post.id, post.text).then () ->
          alertsServ.success('Update Post', 'You\'ve updated a post')
      , (error) ->
          alertsServ.error(error)
    findOwner: (post) ->
      $meteor.object(Meteor.users, post.userId, false).subscribe('usersBasicInfo')

postsServ.$inject = ['$meteor', '$q', 'alertsServ']

angular.module 'posts'
.service 'postsServ', postsServ
