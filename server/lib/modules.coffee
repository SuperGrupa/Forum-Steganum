@require = (name) ->
    if (objects[name] == undefined)
            throw new (Meteor.Error)('Module name don\'t exists')
    objects[name]

objects = {}

@module =
    exports: (name, object) ->
        if (objects[name] != undefined)
            throw new (Meteor.Error)('Module name duplication')
        objects[name] = object
