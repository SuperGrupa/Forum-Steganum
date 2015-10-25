describe 'App run', ->
  $rootScope = {}
  $state = {}

  beforeEach module('forumSteganum')


  beforeEach inject(($injector) ->
    $state = $injector.get('$state')
    $rootScope = $injector.get('$rootScope')
  )

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


