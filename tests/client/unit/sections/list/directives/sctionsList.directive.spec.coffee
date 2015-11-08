'use strict'

describe 'Directive: sectionsList', ->
    beforeEach module 'sections',
        singleSectionDirective:
            restrict: 'AE'
        postsServ: {}
    beforeEach module 'templates'

    element = {}
    mockedSections = ['section1', 'section2']

    beforeEach ->
        element = new TestElement 'sectionsList'
        element.create '<sections-list sections="sections"></sections-list>',
            sections: mockedSections

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should set mockedSections to scope', ->
        expect(element.scope.sections).toBe mockedSections
