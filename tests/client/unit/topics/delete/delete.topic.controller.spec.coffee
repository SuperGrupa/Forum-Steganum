describe 'DeleteTopic controller', ->
    $scope = { }
    $controller = { }
    DeleteTopicCtrl = { }
    mockedTopicsServ = { }

    beforeEach module 'forumSteganum'

    beforeEach inject ($injector) ->
        $controller = $injector.get('$controller')
        $scope = $injector.get('$rootScope').$new()
        DeleteTopicCtrl = $controller 'DeleteTopicCtrl as DeleteTopicCtrl',
            topicsServ: mockedTopicsServ

    it 'should initialize', ->
        expect(DeleteTopicCtrl).toBeDefined()

    # it 'should set topicsServ to topicsCtrl.topic', ->
    #     expect(TopicsCtrl.topic).toBe(mockedTopicsServ)
