Meteor.startup ->
    config =
        run_seed: (process.env.SEED == "true" || process.env.NODE_ENV == "production")

    if config.run_seed
        Meteor.call 'seedPosts'
        Meteor.call 'seedTopics'
        Meteor.call 'seedSections'
        Meteor.call 'seedImages'

        # to jest tutaj po to, żeby seed następował max 1 raz na uruchomienie serwera, a nie przy każdym restarcie
        process.env.SEED = "false"
