@Counters = new Mongo.Collection('counters')

Meteor.startup ->
    config =
        run_seed: (process.env.SEED == "true" || process.env.NODE_ENV == "production")
        run_seed_roles: (Roles.find().count() == 0 || process.env.SEED_ROLES == "true")

    if config.run_seed
        Meteor.call 'seedPosts'
        Meteor.call 'seedTopics'
        Meteor.call 'seedSections'

        # to jest tutaj po to, żeby seed następował max 1 raz na uruchomienie serwera, a nie przy każdym restarcie
        process.env.SEED = "false"

    if config.run_seed_roles
      Meteor.call 'seedRoles'

    Meteor.call 'seedUsers'

