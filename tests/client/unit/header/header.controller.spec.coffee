describe 'Header controller', ->
  $scope = {}
  $controller = {}
  HeaderCtrl = {}
  mockedAuthServ = {
    logout: angular.noop
  }
  successCallBack = null
  failCallBack = null

  beforeEach module('forumSteganum')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    HeaderCtrl = $controller('HeaderCtrl as headCtrl',
      $scope: $scope
      authServ: mockedAuthServ
    )
  )

  it 'should initialize', ->
    expect(HeaderCtrl).toBeDefined()

  describe 'logout', ->
    beforeEach (done) ->
      spyOn(mockedAuthServ, 'logout').and.returnValue true

      HeaderCtrl.logout()
      done()

    it 'should call logout method on meteor', () ->
      expect(mockedAuthServ.logout).toHaveBeenCalled()
