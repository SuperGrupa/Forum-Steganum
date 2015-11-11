describe 'ShowSection controller', ->
    $scope = { }
    $controller = { }
    ShowSectionCtrl = { }
    mockedSectionsServ =
        getTopics: angular.noop
    mockedStateParams =
        section_id: 96
    mockedState =
        goBack: angular.noop
    successCallback = {}
    topics = [
        'Super Best Friends'
        'Better Super Best Friends'
    ]

    beforeEach module 'forumSteganum'

    beforeEach (done) ->
        spyOn(mockedSectionsServ, 'getTopics').and.returnValue topics
        done()

    beforeEach inject ($injector) ->
        $controller = $injector.get('$controller')
        $scope = $injector.get('$rootScope').$new()
        ShowSectionCtrl = $controller 'ShowSectionCtrl',
            $scope: $scope
            sectionsServ: mockedSectionsServ
            $stateParams: mockedStateParams

    it 'should initialize', ->
        expect(ShowSectionCtrl).toBeDefined()

    it 'should call getTopics method on sectionsServ with section.id', ->
        expect(mockedSectionsServ.getTopics).toHaveBeenCalledWith(mockedStateParams.section_id)

    it 'should set topics from sectionsServ.getTopics to vm.topics', () ->
        expect(ShowSectionCtrl.topics).toBe topics

    it 'should set section_id from mockedStateParams to vm.id', () ->
        expect(ShowSectionCtrl.id).toBe mockedStateParams.section_id

    it 'should set sectionsServ to vm.section', () ->
        expect(ShowSectionCtrl.section).toBe mockedSectionsServ
