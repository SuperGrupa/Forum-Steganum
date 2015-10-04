describe 'Users controller', ->
  $scope = {}
  $controller = {}
  UserCtrl = {}
  mockedAuthServ = {
    email: 'bat@man.pl'
  }

  beforeEach module('forumSteganum')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    UserCtrl = $controller('UserCtrl as userCtrl',
      $scope: $scope
      authServ: mockedAuthServ
    )
  )

  it 'should initialize', ->
    expect(UserCtrl).toBeDefined()

  it 'should set authServ to userCtrl.auth', ->
    expect(UserCtrl.auth).toBe(mockedAuthServ)

