Meteor.methods
    seedImages: ->
        # wyczyść bazę danych (kolekcja obrazków)
        Images.remove {}
