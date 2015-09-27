describe 'Header controller', ->
  $scope = {}
  $controller = {}
  HeaderCtrl = {}
  mockedPostServ = {
    something: 'something'
    }

  beforeEach module('forumSteganum',
      postsServ: {}
    )
  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    HeaderCtrl = $controller('HeaderCtrl as headCtrl',
      $scope: $scope
    )
  )

  it 'should initialize', ->
    expect(HeaderCtrl).toBeDefined()
