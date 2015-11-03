'use strict'

describe 'Directive: newTopic', ->
    beforeEach module 'topics',
        $meteor: { }
        sectionsServ:
            getSectionById: -> Promise
    beforeEach module 'templates'

    element = { }

    beforeEach ->
        element = new TestElement 'newTopic'
        element.create '<new-topic></new-topic>'

    it 'should compile', ->
        expect(element.dom).toBeDefined()
