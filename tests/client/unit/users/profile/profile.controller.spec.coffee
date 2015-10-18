describe 'Profile controller', ->
  $scope = {}
  $controller = {}
  ProfileCtrl = {}
  mockedUsersServ = {}

  beforeEach module('users')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    ProfileCtrl = $controller('ProfileCtrl as prof',
      $scope: $scope
      usersServ: mockedUsersServ
    )
  )

  it 'should initialize', ->
    expect(ProfileCtrl).toBeDefined()

  it 'should set usersServ to vm.actions', ->
    expect(ProfileCtrl.actions).toBe(mockedUsersServ)
