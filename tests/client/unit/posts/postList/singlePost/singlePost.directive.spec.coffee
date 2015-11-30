'use strict'

describe 'Directive: singlePost', ->
    beforeEach module 'posts'
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

    describe 'postImage method', ->
        url = ''

        beforeEach ->
            spyOn(Images, 'findOne').and.returnValue
                url: -> 'gotham.png'
            url = element.ctrl.postImage()

        it 'should return url for post\' image', ->
            expect(url).toEqual('gotham.png')
