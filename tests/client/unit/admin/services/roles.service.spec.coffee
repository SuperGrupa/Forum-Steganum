describe 'rolesA Service', ->
    rolesAServ = {}
    collectionArguments = {}
    subscribeArgument = {}
    mockedMeteor = new TestServ()

    mockedAlertsServ = new TestServ()

    beforeEach ->
        mockedMeteor.addPromise('call')
        mockedMeteor.collection = (arg1, arg2) ->
            collectionArguments =
                one: arg1
                two: arg2
            return subscribe: (arg) ->
                subscribeArgument = arg
        mockedAlertsServ.addMethod('success')
        mockedAlertsServ.addMethod('error')

    beforeEach module('admin',
        $meteor: mockedMeteor
        alertsServ: mockedAlertsServ
    )

    beforeEach ->
        rolesAServ = new TestServ('rolesAServ')

    it 'should initialize', ->
        expect(rolesAServ).toBeDefined()


    describe 'getAllRoles method', ->
        beforeEach ->
            rolesAServ.getAllRoles()

        it 'should call collection method on $meteor with proper arguments', ->
            expect(collectionArguments).toEqual
                one: {}
                two: false

        it 'should call subscribe method on $meteor.collection object with proper arguments', ->
            expect(subscribeArgument).toBe 'rolesAdminPanel'

    describe 'emptyRole method', ->
        beforeEach ->
            rolesAServ.emptyRole()

        it 'should call call method on $meteor with "emptyRole" and role', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('emptyRole')

    describe 'createRole method', ->
        someRole =
            name: 'Chuck Norris'

        beforeEach ->
            rolesAServ.createRole(someRole)

        it 'should call call method on $meteor with "createRole" and role', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('createRole', someRole)

    describe 'updateRole method', ->
        someRole =
            name: 'Texas Ranger'

        beforeEach ->
            rolesAServ.updateRole(someRole)

        it 'should call call method on $meteor with "updateRole" and role', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('updateRole', someRole)

    describe 'removeRole method', ->
        error = 'It\'s over 9000!'
        anotherRole =
            name: 'SuperHero'

        beforeEach ->
            rolesAServ.removeRole(anotherRole)

        it 'should call deleteUser method on $meteor.call with role', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('deleteRole', anotherRole)

        describe 'success promise', ->
            it 'should call success method on alertsServ', () ->
                mockedMeteor.call.success()
                expect(mockedAlertsServ.success).toHaveBeenCalled()

        describe 'fail promise', ->
            it 'should call error method on alertsServ with error', ->
                mockedMeteor.call.fail(error)
                expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)

