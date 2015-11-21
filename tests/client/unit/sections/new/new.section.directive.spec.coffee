'use strict'

describe 'Directive: newSection', ->
    element = {}
    section =
        name: 'SuperNova'
        description: 'SuperDescription'

    beforeEach module 'sections'
    beforeEach module 'templates'

    beforeEach ->
        element = new TestElement 'newSection'
        element.create '<new-section></new-section>'

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should create proper section object', () ->
        expect(element.ctrl.section).toEqual { }
