'use strict'

describe 'Directive: authButtons', ->
    beforeEach module 'users',
        mdButtonDirective:
            restrict: 'AE'
    beforeEach module 'templates'

    element = {}

    compileElement = (isLogin) ->
        element = new TestElement 'authButtons'
        element.create '<auth-buttons login="isLogin"></auth-buttons>',
            isLogin: isLogin


    describe 'for login', ->
        beforeEach (done) ->
            compileElement(true)
            done()

        it 'should compile', ->
            expect(element.dom).toBeDefined()

        it 'first button should have md-raised class', ->
            expect(element.dom.find('.login-button').hasClass('md-raised')).toBe true

        it 'second button should not have md-raised class', ->
            expect(element.dom.find('.register-button').hasClass('md-raised')).toBe false


    describe 'for register', ->
        beforeEach (done) ->
            compileElement(false)
            done()

        it 'should compile', ->
            expect(element.dom).toBeDefined()

        it 'first button should not have md-raised class', ->
            expect(element.dom.find('.login-button').hasClass('md-raised')).toBe false

        it 'second button should have md-raised class', ->
            expect(element.dom.find('.register-button').hasClass('md-raised')).toBe true
