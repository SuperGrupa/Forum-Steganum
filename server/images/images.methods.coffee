Images.allow
    insert: ->
        true
    update: ->
        false
    remove: ->
        false
    download: ->
        true

Images.deny
    insert: ->
        false
    update: ->
        true
    remove: ->
        true
    download: ->
        false
