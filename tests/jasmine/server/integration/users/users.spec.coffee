describe 'Users', ->
    describe 'updateUsername method', ->
        it 'should throw not-authorized exception when user not logged', ->
            Helpers.logout()
            Meteor.call 'updateUsername', 'Bartas', (error) ->
                expect(error).toEqual(new Meteor.Error(500, 'You are not logged in'))

        it 'should update username when logged', ->
            Helpers.login('admin')
            Meteor.call 'updateUsername', 'Bartass'

            user = Meteor.users.findOne({ role: 'admin' })

            expect(user.username).toEqual('Bartass')

    describe 'updateEmail method', ->
        it 'should throw not-authorized exception when user not logged', ->
            Helpers.logout()
            Meteor.call 'updateEmail', 'bartas@gmail.com', (error) ->
                expect(error).toEqual(new Meteor.Error(500, 'You are not logged in'))

        it 'should update email when logged', ->
            Helpers.login('admin')
            Meteor.call 'updateEmail', 'bartas1@gmail.com'

            user = Meteor.users.findOne({ role: 'admin' })

            expect(user.emails[0].address).toEqual('bartas1@gmail.com')

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
            Helpers.login('admin')
            Meteor.call 'updateProfile', profile

            user = Meteor.users.findOne({ role: 'admin' })

            expect(user.profile).toEqual(profile)
