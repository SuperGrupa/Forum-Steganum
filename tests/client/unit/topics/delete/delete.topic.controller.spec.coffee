describe 'DeleteTopic controller', ->
    $scope = { }
    $controller = { }
    DeleteTopicCtrl = { }
    mockedTopicsServ =
        getTopicById: angular.noop
    mockedStateParams =
        topic_id: 69
        section_id: 96
    mockedState =
        goBack: angular.noop
    successCallback = {}
    topic =
        name: 'Super Best Friends'

    beforeEach module 'topics'

    beforeEach (done) ->
        spyOn(mockedTopicsServ, 'getTopicById').and.returnValue
            then: (success) ->
                successCallback = success
        done()

    beforeEach inject ($injector) ->
        $controller = $injector.get('$controller')
        $scope = $injector.get('$rootScope').$new()
        DeleteTopicCtrl = $controller 'DeleteTopicCtrl',
            $scope: $scope
            topicsServ: mockedTopicsServ
            $stateParams: mockedStateParams
            $state: mockedState
        successCallback(topic)

    it 'should initialize', ->
        expect(DeleteTopicCtrl).toBeDefined()

    it 'should call getTopicById method on topicsServ with topic.id', ->
        expect(mockedTopicsServ.getTopicById).toHaveBeenCalledWith(mockedStateParams.topic_id)

    it 'should set result from topicsServ to topic.name', () ->
        expect(DeleteTopicCtrl.topic.name).toBe topic.name

    it 'set $state to vm.state', () ->
        expect(DeleteTopicCtrl.state).toBe mockedState

    it 'set state params to vm.topic', () ->
        expect(DeleteTopicCtrl.topic.id).toBe mockedStateParams.topic_id
        expect(DeleteTopicCtrl.topic.section_id).toBe mockedStateParams.section_id

