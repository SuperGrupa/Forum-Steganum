describe 'Header controller', ->
  $scope = {}
  $controller = {}
  HeaderCtrl = {}
  mockedMeteor = {
    logout: angular.noop
  }
  mockedState = {
    go: angular.noop
  }
  successCallBack = null
  failCallBack = null

  beforeEach module('forumSteganum')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    HeaderCtrl = $controller('HeaderCtrl as headCtrl',
      $scope: $scope
      $meteor: mockedMeteor
      $state: mockedState
    )
  )

  it 'should initialize', ->
    expect(HeaderCtrl).toBeDefined()

  describe 'logout', ->
    beforeEach (done) ->
      spyOn(mockedMeteor, 'logout').and.returnValue
        then: (success, fail) ->
          successCallBack = success;
          failCallBack = fail;
      spyOn(mockedState, 'go')

      HeaderCtrl.logout()
      successCallBack()
      done()

    it 'should call logout method on meteor', () ->
      expect(mockedMeteor.logout).toHaveBeenCalled()

    it 'should call go method on state', () ->
      expect(mockedState.go).toHaveBeenCalledWith 'home'

