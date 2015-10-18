'use strict'

describe 'Directive: newPost', ->
    beforeEach module 'posts',
        $meteor: {}
    beforeEach module 'templates'

    element = {}

    beforeEach ->
        element = new TestElement 'newPost'
        element.create '<new-post></new-post>'

    it 'should compile', ->
        expect(element.dom).toBeDefined()
