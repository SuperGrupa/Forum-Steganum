Images.allow
    insert:   (userId) -> !!userId              # takie rzeczy tylko dla zalogowanych
    update:   (userId) -> !!userId              # i tu też
    remove:   -> false
    download: (userId) -> !!userId              # o, i tu jeszcze jeden przypadek

Images.deny
    insert:   -> false
    update:   -> false
    remove:   -> true
    download: -> false
