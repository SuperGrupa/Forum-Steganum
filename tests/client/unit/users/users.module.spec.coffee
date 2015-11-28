describe 'Users module', ->
    $state = {}
    $rootScope = {}
    $state = {}
    mockedAuthServ =
        isLogged: angular.noop
        isNotLogged: angular.noop

    beforeEach module('forumSteganum',
        authServ: mockedAuthServ)
    beforeEach module('templates')

    beforeEach ->
      inject (_$rootScope_, _$state_) ->
        $rootScope = _$rootScope_
        $state = _$state_

    describe 'login state', ->
        beforeEach (done) ->
            $state.go 'login'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'register state', ->
        beforeEach (done) ->
            $state.go 'register'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'profile state', ->
        beforeEach (done) ->
            $state.go 'profile'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()


