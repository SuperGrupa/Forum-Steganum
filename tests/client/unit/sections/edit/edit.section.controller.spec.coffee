describe 'EditSection controller', ->
    $scope = { }
    $controller = { }
    editSectionController = { }
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
        editSectionController = $controller 'EditSectionCtrl',
            $scope: $scope
            sectionsServ: mockedSectionsServ
            $stateParams: mockedStateParams
            $state: mockedState
        successCallback(section)

    it 'should initialize', ->
        expect(editSectionController).toBeDefined()

    it 'should call getSectionById method on sectionsServ with section.id', ->
        expect(mockedSectionsServ.getSectionById).toHaveBeenCalledWith(mockedStateParams.section_id)

    it 'should set result from sectionsServ to section.name', () ->
        expect(editSectionController.section).toBe section

    it 'should set $state to vm.state', () ->
        expect(editSectionController.state).toBe mockedState
