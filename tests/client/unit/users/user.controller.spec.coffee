describe 'Users controller', ->
  $scope = {}
  $controller = {}
  UserCtrl = {}
  mockedLoginServ = {
    email: 'bat@man.pl'
  }

  beforeEach module('forumSteganum')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    UserCtrl = $controller('UserCtrl as userCtrl',
      $scope: $scope
      loginServ: mockedLoginServ
    )
  )

  it 'should initialize', ->
    expect(UserCtrl).toBeDefined()

  it 'should set authServ to userCtrl.auth', ->
    expect(UserCtrl.auth).toBe(mockedLoginServ)

