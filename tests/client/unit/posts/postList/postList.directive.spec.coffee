'use strict'

describe 'Directive: postList', ->
    beforeEach module 'forumSteganum',
        singlePostDirective:
            restrict: 'AE'
    beforeEach module 'templates'

    element = {}
    mockedPosts = ['post1', 'post2']

    beforeEach ->
        element = new TestElement 'postsList'
        element.create '<posts-list posts="posts"></posts-list>',
            posts: mockedPosts

    it 'should compile', ->
      expect(element.dom).toBeDefined()

    it 'should set mockedPosts to scope', ->
        expect(element.scope.posts).toBe mockedPosts

