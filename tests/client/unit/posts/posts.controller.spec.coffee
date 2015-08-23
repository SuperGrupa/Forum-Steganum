describe 'Posts controller', ->
  $scope = {}
  $controller = {}
  PostCtrl = {}
  mockedPostServ = {
    something: 'something'
    }

  beforeEach module('posts')
  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    PostCtrl = $controller('PostCtrl as postCtrl',
      $scope: $scope,
      postsServ: mockedPostServ)
  )

  it 'should initialize', ->
    expect(PostCtrl).toBeDefined()

  it 'should expose the postsServ on the scope.post', ->
    expect($scope.postCtrl.post).toBe mockedPostServ
