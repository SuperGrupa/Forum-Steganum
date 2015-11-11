describe 'Users', ->
    describe 'updateUsername method', ->
        it 'should throw not-authorized exception when user not logged', ->
            Helpers.logout()
            Meteor.call 'updateUsername', 'Bartas', (error) ->
                expect(error).toEqual(new Meteor.Error(500, 'You are not logged in'))

        it 'should update username when logged', ->
            Helpers.login()
            Meteor.call 'updateUsername', 'Bartas'

            expect(Meteor.user().username).toEqual('Bartas')

    describe 'updateEmail method', ->
        it 'should throw not-authorized exception when user not logged', ->
            Helpers.logout()
            Meteor.call 'updateEmail', 'bartas@gmail.com', (error) ->
                expect(error).toEqual(new Meteor.Error(500, 'You are not logged in'))

        it 'should update email when logged', ->
            Helpers.login()
            Meteor.call 'updateEmail', 'bartas@gmail.com'

            expect(Meteor.user().emails[0].address).toEqual('bartas@gmail.com')

    describe 'updateProfile method', ->
        profile =
            firstname: 'Bartas'
            lastname: 'Nitrooos'
            catname: 'Kociusz'
            catbread: 'Co popadnie'
            catyeras: '1'
            dogname: 'Idefix'
            dogbreed: 'Tylko wyselekcjonowane psie żarcie'
            dogyeras: '11'

        it 'should throw not-authorized exception when user not logged', ->
            Helpers.logout()
            Meteor.call 'updateProfile', profile, (error) ->
                expect(error).toEqual(new Meteor.Error(500, 'You are not logged in'))

        it 'should update profile when logged', ->
            Helpers.login()
            Meteor.call 'updateProfile', profile

            expect(Meteor.user().profile).toEqual(profile)
