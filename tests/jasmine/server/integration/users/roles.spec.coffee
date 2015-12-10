Helpers = require 'Helpers'

describe 'emptyRole method', ->
    it 'should return empty role with new role as a name', () ->
        expect(Meteor.call 'emptyRole').toEqual
            default: false
            name: 'new role'
            can:
              create: Helpers.ptsu()
              read: Helpers.ptsu()
              update: Helpers.ptsu()
              remove: Helpers.ptsu()

    it 'should return empty role with given name', () ->
        expect(Meteor.call 'emptyRole', 'someName').toEqual
            default: false
            name: 'someName'
            can:
              create: Helpers.ptsu()
              read: Helpers.ptsu()
              update: Helpers.ptsu()
              remove: Helpers.ptsu()

describe 'createRole method', ->
    role =
        can: 'I can!'
        default: 'default'
        name: 'superName'

    it 'should throw not-authorized exception when not admin', ->
        Helpers.logout()
        Meteor.call 'createRole', role, (error) ->
            expect(error).toEqual(new Meteor.Error('notAuthorized'))

    it 'should update user when admin', ->
        Helpers.login('admin')
        Meteor.call 'createRole', role

        expect(Roles.findOne({ name: role.name })).toEqual
            _id: jasmine.any(String)
            name: role.name
            can: role.can
            default: role.default

        Roles.remove { name: role.name }

describe 'modify role', ->
    role = {}
    roleName = 'someRole'

    beforeEach (done) ->
        Roles.insert
            can: 'I can!'
            default: 'default'
            name: roleName
        role = Roles.findOne({ name: roleName })
        done()

    afterEach (done) ->
        Roles.remove { name: roleName }
        done()

    describe 'updateRole method', ->
        it 'should throw not-authorized exception when not admin', ->
            Helpers.logout()
            Meteor.call 'updateRole', role, (error) ->
                expect(error).toEqual(new Meteor.Error('notAuthorized'))

        it 'should update role when admin', ->
            Helpers.login('admin')
            role.can = 'No, I can\'t.'
            Meteor.call 'updateRole', role

            role = Roles.findOne { name: roleName }

            expect(role).toEqual
                _id: jasmine.any(String)
                name: role.name
                can: 'No, I can\'t.'
                default: role.default


    describe 'deleteRole method', ->
        it 'should throw not-authorized exception when not admin', ->
            Helpers.logout()
            Meteor.call 'deleteRole', role, (error) ->
                expect(error).toEqual(new Meteor.Error('notAuthorized'))

        it 'should remove role when admin', ->
            Helpers.login('admin')
            role = Roles.findOne({ name: roleName })
            Meteor.call 'deleteRole', role

            expect(Roles.findOne({ name: roleName })).toBeFalsy()

describe 'remove role that is set to user', ->
    role = {}
    roleName = 'someRole'
    user = {}
    userName = 'someUsername'

    beforeEach (done) ->
        Roles.insert
            can: 'I can!'
            default: true
            name: roleName
        role = Roles.findOne({ name: roleName })
        Accounts.createUser
                username: userName,
                email : 'email@fs.pl',
                password : '1234'
                role: roleName
            user = Meteor.users.findOne({ username: userName })
        done()

    afterEach (done) ->
        Roles.remove { name: roleName }
        Meteor.users.remove { username: userName }
        done()


    it 'should set default role to user ', () ->
        Helpers.login('admin')

        role = Roles.findOne({ name: roleName })
        Meteor.call 'deleteRole', role

        user = Meteor.users.findOne({ username: userName })

        expect(user.role).toEqual('user')
