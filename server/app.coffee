Meteor.startup ->
    config =
        run_seed: process.env.SEED == "true"

    if config.run_seed
        Meteor.call 'seedPosts'
        Meteor.call 'seedTopics'
        Meteor.call 'seedSections'
