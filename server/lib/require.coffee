@require = (name) ->
    objects[name]

objects = {}

@module =
    exports: (name, object) ->
        objects[name] = object
