describe 'Topics module', ->
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

    describe 'topic.new state', ->
        beforeEach (done) ->
            $state.go 'topic.new'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'topic.posts state', ->
        beforeEach (done) ->
            $state.go 'topic.show'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'topic.delete state', ->
        beforeEach (done) ->
            $state.go 'topic.delete'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

    describe 'topic.edit state', ->
        beforeEach (done) ->
            $state.go 'topic.edit'
            $rootScope.$digest()
            done()

        describe 'Resolve function', ->
          beforeEach ->
            $state.current.resolve

          it 'should be defined', ->
            expect($state.current.resolve).toBeDefined()

