'use strict'

describe 'Directive: newSection', ->
    element = {}
    section =
        name: 'SuperNova'

    beforeEach module 'sections'
    beforeEach module 'templates'

    beforeEach ->
        element = new TestElement 'newSection'
        element.create '<new-section></new-section>'

    # it 'should compile', ->
    #     expect(element.dom).toBeDefined()
    #
    # it 'should create proper section object', () ->
    #     expect(element.ctrl.section).toEqual
    #         name: ''
    #         description: ''
    #
    # it 'should call getSectionById method on sectionsServ with section_id', () ->
    #     expect(mockedSectionsServ.getSectionById).toHaveBeenCalledWith mockedStateParams.section_id
    #
    # it 'should set result from sectionsServ to vm.section', () ->
    #     expect(element.ctrl.section.name).toBe section.name
