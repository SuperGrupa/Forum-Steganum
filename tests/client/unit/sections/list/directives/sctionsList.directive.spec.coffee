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
        element = new TestElement()
        element.createDirective 'sectionsList', '<sections-list sections="sections"></sections-list>',
            sections: mockedSections
            can: -> true

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should set mockedSections to scope', ->
        expect(element.scope.sections).toBe mockedSections
