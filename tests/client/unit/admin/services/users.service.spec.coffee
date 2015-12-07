describe 'usersA Service', ->
    usersAServ = {}
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
        usersAServ = new TestServ('usersAServ')

    it 'should initialize', ->
        expect(usersAServ).toBeDefined()


    describe 'getAllUsers method', ->
        beforeEach ->
            usersAServ.getAllUsers()

        it 'should call collection method on $meteor with proper arguments', ->
            expect(collectionArguments).toEqual
                one: {}
                two: false

        it 'should call subscribe method on $meteor.collection object with proper arguments', ->
            expect(subscribeArgument).toBe 'usersAdminPanel'

    describe 'updateUser method', ->
        someUser =
            name: 'Clint Eastwood'

        beforeEach ->
            usersAServ.updateUser(someUser)

        it 'should call call method on $meteor with "updateUser" and user', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('updateUser', someUser)

    describe 'removeUser method', ->
        error = 'It\'s over 9000!'
        user_id = 1234

        beforeEach ->
            usersAServ.removeUser(user_id)

        it 'should call deleteUser method on $meteor.call with user_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('deleteUser', user_id)

        describe 'success promise', ->
            it 'should call success method on alertsServ', () ->
                mockedMeteor.call.success()
                expect(mockedAlertsServ.success).toHaveBeenCalled()

        describe 'fail promise', ->
            it 'should call error method on alertsServ with error', ->
                mockedMeteor.call.fail(error)
                expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)

