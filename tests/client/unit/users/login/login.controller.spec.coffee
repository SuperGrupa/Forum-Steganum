describe 'Login controller', ->
  $scope = {}
  $controller = {}
  LoginCtrl = {}

  beforeEach module('forumSteganum')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    LoginCtrl = $controller('LoginCtrl as logCtrl',
      $scope: $scope
    )
  )

  it 'should initialize', ->
    expect(LoginCtrl).toBeDefined()
