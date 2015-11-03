'use strict'

describe 'Directive: editTopic', ->
    beforeEach module 'topics',
        $meteor:
            call: -> Promise
        sectionsServ:
            getSectionById: -> Promise
    beforeEach module 'templates'

    element = { }

    beforeEach ->
        element = new TestElement 'editTopic'
        element.create '<edit-topic></edit-topic>'

    it 'should compile', ->
        expect(element.dom).toBeDefined()
