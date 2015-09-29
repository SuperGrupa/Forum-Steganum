describe 'Users controller', ->
  $scope = {}
  $controller = {}
  UserCtrl = {}

  beforeEach module('forumSteganum')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    UserCtrl = $controller('UserCtrl as userCtrl',
      $scope: $scope
    )
  )

  it 'should initialize', ->
    expect(UserCtrl).toBeDefined()

