describe 'Sections module', ->
    $state = {}
    $rootScope = {}
    $state = {}
    mockedAuthServ =
        isLogged: angular.noop
        stateCan: angular.noop

    beforeEach module('forumSteganum',
        authServ: mockedAuthServ)
    beforeEach module('templates')

    beforeEach ->
      inject (_$rootScope_, _$state_) ->
        $rootScope = _$rootScope_
        $state = _$state_

    describe 'section.new state', ->
        beforeEach (done) ->
            $state.go 'section.new'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'section.one.show state', ->
        beforeEach (done) ->
            $state.go 'section.one.show'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'section.one.delete state', ->
        beforeEach (done) ->
            $state.go 'section.one.delete'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'section.one.edit state', ->
        beforeEach (done) ->
            $state.go 'section.one.edit'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

