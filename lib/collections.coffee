@Sections = new Mongo.Collection('sections')
@Topics = new Mongo.Collection('topics')
@Posts = new Mongo.Collection('posts')

# Przechowywanie obrazków w bazie danych MongoDB
imageStore = new FS.Store.GridFS('images');
@Images = new FS.Collection 'images',
    stores: [imageStore]
    filter:
        maxSize: 1048576                # w bajtach
        allow:
            contentTypes: ['image/*'],
            extensions: ['png', 'bmp']
        onInvalid: (message) ->
            if (Meteor.isClient)
                alert(message)
            else
                console.log(message)
