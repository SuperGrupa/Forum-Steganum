describe 'Topics controller', ->
    $scope = { }
    $controller = { }
    TopicsCtrl = { }
    mockedTopicsServ = { }

    beforeEach module 'topics'

    beforeEach inject ($injector) ->
        $controller = $injector.get('$controller')
        $scope = $injector.get('$rootScope').$new()
        TopicsCtrl = $controller 'TopicsCtrl as topicsCtrl',
            $scope: $scope
            topicsServ: mockedTopicsServ

    it 'should initialize', ->
        expect(TopicsCtrl).toBeDefined()

    it 'should set topicsServ to topicsCtrl.topic', ->
        expect(TopicsCtrl.topic).toBe(mockedTopicsServ)
