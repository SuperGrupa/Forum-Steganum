'use strict'

describe 'Directive: singlePost', ->
    beforeEach module 'forumSteganum'
    beforeEach module 'templates'

    element = {}
    mockedPost =
        text: 'someText'

    beforeEach ->
        element = new TestElement 'singlePost'
        element.create '<single-post post="post"></single-post>',
            post: mockedPost

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should set mockedPost to scope', ->
        expect(element.scope.post).toBe mockedPost
