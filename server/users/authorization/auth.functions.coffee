module.exports 'authFunctions',
    can: (what, name, object, userId) ->
        if what != 'read' then userId = Meteor.userId()
        if typeof object == 'string'
            found = switch name
                when 'post' then Posts.findOne({ id: object })
                when 'topic' then Topics.findOne({ id: object })
                when 'section' then Sections.findOne({ id: object })
                when 'user' then Meteor.users.findOne({ id: object })
            return checkAuth(what, name, found, userId)
        return checkAuth(what, name, object, userId)


checkAuth = (what, name, object, userId) ->
    if !userId
        throw new (Meteor.Error)('not-logged')
        return false

    user = Meteor.users.findOne({_id: userId})

    if user.can[what][name]
        return true

    if name == 'post'
        if object.topic_id in user.can[what].in.topic
            return true
        sectionId = Topics.findOne({ id: object.topic_id }).section_id
        if sectionId in user.can[what].in.section
            return true

    if name == 'topic'
        if object.section_id in user.can[what].in.section
            return true

    if user.can[what].self[name] && userId == object.userId
        return true

    throw new (Meteor.Error)('not-authorized')
    return false
