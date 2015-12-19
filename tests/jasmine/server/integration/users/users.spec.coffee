Helpers = require 'Helpers'

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

    describe 'admin panel', ->
        user = {}
        userName = 'someUsername'

        beforeEach (done) ->
            Accounts.createUser
                username: userName,
                email : 'email@fs.pl',
                password : '1234'
            user = Meteor.users.findOne({ username: userName })
            done()

        afterEach (done) ->
            Meteor.users.remove { username: userName }
            done()

        describe 'updateUser method', ->
            it 'should throw not-authorized exception when not admin', ->
                Helpers.logout()
                Meteor.call 'updateUser', user, (error) ->
                    expect(error).toEqual(new Meteor.Error('notAuthorized'))

            it 'should update user when admin', ->
                Helpers.login('admin')
                user.role = 'moderator'
                Meteor.call 'updateUser', user

                user = Meteor.users.findOne({ username: userName })

                expect(user.role).toEqual('moderator')


        describe 'deleteUser method', ->
            it 'should throw not-authorized exception when not admin', ->
                Helpers.logout()
                Meteor.call 'deleteUser', user, (error) ->
                    expect(error).toEqual(new Meteor.Error('notAuthorized'))

            it 'should remove user when admin', ->
                Helpers.login('admin')
                user = Meteor.users.findOne({ username: userName })
                Meteor.call 'deleteUser', user._id

                expect(Meteor.users.findOne({ username: userName })).toBeFalsy()
