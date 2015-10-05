'use strict'

describe 'Directive: showMessage', ->
    beforeEach module 'common'
    beforeEach module 'templates'

    element = {}

    compileElement = (message, type) ->
        element = new TestElement 'showMessage'
        element.create '<show-message message="message" type="' + type + '"></show-message>',
            message: message


    describe 'error message', ->
        message = 'some error message'
        beforeEach (done) ->
            compileElement(message, 'error')
            done()

        it 'should compile', ->
            expect(element.dom).toBeDefined()

        it 'message should have md-warn class', ->
            expect(element.dom.find('div').hasClass('md-warn')).toBe true

        it 'message should have error-container class', ->
            expect(element.dom.find('div').hasClass('error-container')).toBe true

    describe 'other message', ->
        message = 'some other message'
        beforeEach (done) ->
            compileElement(message, 'other')
            done()

        it 'should compile', ->
            expect(element.dom).toBeDefined()

        it 'message should not have md-warn class', ->
            expect(element.dom.find('div').hasClass('md-warn')).toBe false

        it 'message should not have error-container class', ->
            expect(element.dom.find('div').hasClass('error-container')).toBe false


    describe 'no message', ->
        message = ''
        beforeEach (done) ->
            compileElement(message, 'other')
            done()

        it 'should compile', ->
            expect(element.dom).toBeDefined()

        it 'message should have ng-hide class', ->
            expect(element.dom.find('div').hasClass('ng-hide')).toBe true
