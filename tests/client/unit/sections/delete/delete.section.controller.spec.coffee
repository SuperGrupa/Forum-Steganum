describe 'DeleteSection controller', ->
    $scope = { }
    $controller = { }
    DeleteSectionCtrl = { }
    mockedSectionsServ =
        getSectionById: angular.noop
    mockedStateParams =
        section_id: 96
    mockedState =
        goBack: angular.noop
    successCallback = {}
    section =
        name: 'Super Best Friends'

    beforeEach module 'sections'

    beforeEach (done) ->
        spyOn(mockedSectionsServ, 'getSectionById').and.returnValue
            then: (success) ->
                successCallback = success
        done()

    beforeEach inject ($injector) ->
        $controller = $injector.get('$controller')
        $scope = $injector.get('$rootScope').$new()
        DeleteSectionCtrl = $controller 'DeleteSectionCtrl',
            $scope: $scope
            sectionsServ: mockedSectionsServ
            $stateParams: mockedStateParams
            $state: mockedState
        successCallback(section)

    it 'should initialize', ->
        expect(DeleteSectionCtrl).toBeDefined()

    it 'should call getSectionById method on sectionsServ with section.id', ->
        expect(mockedSectionsServ.getSectionById).toHaveBeenCalledWith(mockedStateParams.section_id)

    it 'should set result from sectionsServ to section.name', () ->
        expect(DeleteSectionCtrl.section.name).toBe section.name

    it 'set $state to vm.state', () ->
        expect(DeleteSectionCtrl.state).toBe mockedState

    it 'set state params to vm.section', () ->
        expect(DeleteSectionCtrl.section.id).toBe mockedStateParams.section_id

