describe 'Admin module', ->
    $state = {}
    $rootScope = {}
    $state = {}
    mockedAuthServ = new TestServ()

    beforeEach ->
        mockedAuthServ.addMethod('hasRole')

    beforeEach module('forumSteganum',
        authServ: mockedAuthServ)
    beforeEach module('templates')

    beforeEach ->
        $rootScope = new TestServ('$rootScope')
        $state = new TestServ('$state')

    describe 'admin.main state', ->
        beforeEach (done) ->
            $state.go 'admin.main'
            $rootScope.$digest()
            done()

        describe 'Resolve function in parent', ->
          it 'should be defined', ->
            expect($state.$current.parent.resolve).toBeDefined()



