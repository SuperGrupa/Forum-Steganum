'use strict'

describe 'Directive: singleSection', ->
    beforeEach module 'sections'
    beforeEach module 'templates'

    element = {}
    mockedSection =
        text: 'someText'

    beforeEach ->
        element = new TestElement()
        element.createDirective 'singleSection', '<single-section section="section"></single-section>',
            section: mockedSection

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should set mockedSection to scope', ->
        expect(element.scope.section).toBe mockedSection
