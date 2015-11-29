describe 'App run', ->
  $rootScope = {}
  $state = {}
  mockedAuthServ =
    can: 'something'

  beforeEach module('forumSteganum',
    authServ: mockedAuthServ)


  beforeEach inject(($injector) ->
    $state = $injector.get('$state')
    $rootScope = $injector.get('$rootScope')
  )

  describe '$rootScope', ->
    it 'should bind authServ.can to $rootScope', () ->
      expect($rootScope.can).toBe(mockedAuthServ.can)

  describe 'goBack method on $state', ->
    describe 'is previous state', ->
      previousState = {
        name: 'superState'
      }
      previousParams =
        id: '1234'

      beforeEach (done) ->
        $state.previous = previousState
        $state.previousParams = previousParams
        spyOn($state, 'go').and.returnValue true
        $state.goBack()
        done()

      it 'should call go method with $state.previous and $state.previousParams', () ->
        expect($state.go).toHaveBeenCalledWith previousState, previousParams

    describe 'no previous state', ->
      previousState = {
        name: undefined
      }

      beforeEach (done) ->
        $state.previous = previousState
        spyOn($state, 'go').and.returnValue true
        $state.goBack()
        done()

      it 'should call go method with "home"', () ->
        expect($state.go).toHaveBeenCalledWith 'home'

  describe '$stateChangeError', ->
    error = ''

    describe 'AUTH_REQUIRED error', ->
      beforeEach (done) ->
        error = 'AUTH_REQUIRED'
        spyOn($state, 'go').and.returnValue true
        $rootScope.$emit('$stateChangeError', null, null, null, null, error)
        done()

      it 'should go to login state', () ->
        expect($state.go).toHaveBeenCalledWith('login')

    describe 'UNAUTHORIZED error', ->
      beforeEach (done) ->
        error = 'UNAUTHORIZED'
        spyOn($state, 'go').and.returnValue true
        $rootScope.$emit('$stateChangeError', null, null, null, null, error)
        done()

      it 'should go to error state with proper params', () ->
        expect($state.go).toHaveBeenCalledWith('error', { code: 401, text: 'Unauthorized' })

    describe 'ALREADYLOGGED error', ->
      beforeEach (done) ->
        error = 'ALREADYLOGGED'
        spyOn($state, 'go').and.returnValue true
        $rootScope.$emit('$stateChangeError', null, null, null, null, error)
        done()

      it 'should go to home state', () ->
        expect($state.go).toHaveBeenCalledWith('home')

    describe 'else error', ->
      beforeEach (done) ->
        error = 'something else'
        spyOn($state, 'go').and.returnValue true
        $rootScope.$emit('$stateChangeError', null, null, null, null, error)
        done()

      it 'should go to error state', () ->
        expect($state.go).toHaveBeenCalledWith('error')

  describe '$stateChangeSuccess', ->
    describe 'from normal state', ->
      fromState =
        name: 'someState'
      fromParams =
        id: 456

      beforeEach (done) ->
        spyOn($state, 'go').and.returnValue true
        $rootScope.$emit('$stateChangeSuccess', null, null, fromState, fromParams)
        done()

      it 'should set fromState to $state.previous', () ->
        expect($state.previous).toBe fromState

      it 'should set fromParams to $state.previousParams', () ->
        expect($state.previousParams).toBe fromParams

    describe 'from login state', ->
      savedState =
        name: 'anotherState'
      savedParams =
        id: 123
      fromState =
        name: 'login'
      fromParams =
        id: 890

      beforeEach (done) ->
        spyOn($state, 'go').and.returnValue true
        $rootScope.$emit('$stateChangeSuccess', null, null, savedState, savedParams)
        $rootScope.$emit('$stateChangeSuccess', null, null, fromState, fromParams)
        done()

      it 'should set savedState to $state.previous', () ->
        expect($state.previous).toBe savedState

      it 'should set savedParams to $state.previousParams', () ->
        expect($state.previousParams).toBe savedParams

    describe 'from register state', ->
      savedState =
        name: 'anotherState'
      savedParams =
        id: 123
      fromState =
        name: 'register'
      fromParams =
        id: 890

      beforeEach (done) ->
        spyOn($state, 'go').and.returnValue true
        $rootScope.$emit('$stateChangeSuccess', null, null, savedState, savedParams)
        $rootScope.$emit('$stateChangeSuccess', null, null, fromState, fromParams)
        done()

      it 'should set savedState to $state.previous', () ->
        expect($state.previous).toBe savedState

      it 'should set savedParams to $state.previousParams', () ->
        expect($state.previousParams).toBe savedParams


