describe 'Header controller', ->
  $scope = {}
  $controller = {}
  HeaderCtrl = {}
  mockedLoginServ = {
    logout: angular.noop
  }
  successCallBack = null
  failCallBack = null

  beforeEach module('forumSteganum',
    authServ: {})

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    HeaderCtrl = $controller('HeaderCtrl as headCtrl',
      $scope: $scope
      loginServ: mockedLoginServ
    )
  )

  it 'should initialize', ->
    expect(HeaderCtrl).toBeDefined()

  describe 'logout', ->
    beforeEach (done) ->
      spyOn(mockedLoginServ, 'logout').and.returnValue true

      HeaderCtrl.logout()
      done()

    it 'should call logout method on meteor', () ->
      expect(mockedLoginServ.logout).toHaveBeenCalled()
