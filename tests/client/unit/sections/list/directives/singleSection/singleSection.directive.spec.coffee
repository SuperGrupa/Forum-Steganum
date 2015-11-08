'use strict'

describe 'Directive: singleSection', ->
    beforeEach module 'sections'
    beforeEach module 'templates'

    element = {}
    mockedSection =
        text: 'someText'

    beforeEach ->
        element = new TestElement 'singleSection'
        element.create '<single-section section="section"></single-section>',
            section: mockedSection

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should set mockedSection to scope', ->
        expect(element.scope.section).toBe mockedSection
