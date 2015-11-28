describe 'Sections controller', ->
    $scope = { }
    $controller = { }
    SectionCtrl = { }
    mockedSectionsServ = { }

    beforeEach module 'sections'

    beforeEach inject ($injector) ->
        $controller = $injector.get('$controller')
        $scope = $injector.get('$rootScope').$new()
        SectionCtrl = $controller 'SectionCtrl as SectionCtrl',
            $scope: $scope
            sectionsServ: mockedSectionsServ

    it 'should initialize', ->
        expect(SectionCtrl).toBeDefined()

    it 'should set sectionsServ to SectionCtrl.section', ->
        expect(SectionCtrl.section).toBe(mockedSectionsServ)
