describe 'Error controller', ->
  $scope = {}
  $controller = {}
  errorCtrl = {}
  mockedStateParams = {
    some: 'Params'
  }
  successCallBack = null
  failCallBack = null

  beforeEach module('forumSteganum',
    authServ: {})

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    errorCtrl = $controller('errorCtrl',
      $scope: $scope
      $stateParams: mockedStateParams
    )
  )

  it 'should initialize', ->
    expect(errorCtrl).toBeDefined()

  it 'should bind $stateParams to this.params', () ->
    expect(errorCtrl.params).toBe mockedStateParams
