'use strict'

describe 'Directive: newTopic', ->
    element = {}
    mockedSectionsServ =
        getSectionById: angular.noop
    mockedStateParams =
        section_id: 2
    successSectionCallback = {}
    topic =
        title: 'Big Bang!'
    section =
        name: 'SuperNova'

    beforeEach module 'topics',
        sectionsServ: mockedSectionsServ
        $stateParams: mockedStateParams
    beforeEach module 'templates'

    beforeEach (done) ->
        spyOn(mockedSectionsServ, 'getSectionById').and.returnValue
            then: (success) ->
                successSectionCallback = success
        done()

    beforeEach ->
        element = new TestElement 'newTopic'
        element.create '<new-topic></new-topic>'
        successSectionCallback(section)

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should create proper topic object', () ->
        expect(element.ctrl.topic).toEqual {
            section_id: mockedStateParams.section_id
            name: ''
            description: ''
        }

    it 'should call getSectionById method on sectionsServ with section_id', () ->
        expect(mockedSectionsServ.getSectionById).toHaveBeenCalledWith mockedStateParams.section_id

    it 'should set result from sectionsServ to vm.section', () ->
        expect(element.ctrl.section.name).toBe section.name
