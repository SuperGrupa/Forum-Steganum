Meteor.startup ->
    config =
        run_seed: (process.env.SEED == "true" || process.env.NODE_ENV == "production")

    if config.run_seed
        Meteor.call 'seedPosts'
        Meteor.call 'seedTopics'
        Meteor.call 'seedSections'
