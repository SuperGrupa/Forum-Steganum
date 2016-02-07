Meteor.methods
    getImagePublicKey: (image_id) ->
        image = Images.findOne({ _id: image_id })
        if image? && image.metadata?
            return image.metadata.public_key
        return undefined
    setImagePublicKey: () ->
        publicKey = []
        for i in [0...31] by 1
            publicKey.push(Math.random()*4294967295)
        return publicKey
