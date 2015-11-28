'use strict'

describe 'Directive: liveEdit', ->
    object =
        text: 'live edit value'
    config =
        onSave: angular.noop

    beforeEach module 'common'
    beforeEach module 'templates'

    element = { }

    beforeEach (done) ->
        done()

    compileElement = (objectName, onSave, inputType) ->
        element = new TestElement 'liveEdit'
        element.create '<live-edit object="object" on-save="config.onSave(object)" input-type="' + inputType + '"></live-edit>',
            object: object,
            onSave: config.onSave

    describe 'compilation', ->
        beforeEach ->
            compileElement(object, config.onSave, 'password')

        it 'should compile', ->
            expect(element.dom).toBeDefined()
            expect(element.ctrl).toBeDefined()
            expect(element.ctrl.object).toBeDefined()
            expect(element.ctrl.save).toBeDefined()
            expect(element.ctrl.startEditing).toBeDefined()

        it 'should have its own object copy', ->
            expect(element.ctrl.object).toEqual object
            expect(element.ctrl.object).not.toBe object

    describe 'HTML template structure', ->
        beforeEach (done) ->
            compileElement(object, config.onSave, 'password')
            done()

        it 'should have visible object.text', ->
            expect(element.dom.find('[ng-hide="live.editEnabled"]').hasClass('ng-hide')).toBeFalsy

        it 'should have hidden input', ->
            expect(element.dom.find('[ng-show="live.editEnabled"]').hasClass('ng-hide')).toBeTruthy

    describe 'textarea or input?', ->
        it 'should have input with type email', ->
            compileElement(object, config.onSave, 'email')
            expect(element.dom.find('input[type=email]').length).toEqual 1
            expect(element.dom.find('textarea').length).toEqual 0

        it 'should have textarea instead of input', ->
            compileElement(object, config.onSave, 'text')
            expect(element.dom.find('input[type=email]').length).toEqual 0
            expect(element.dom.find('textarea').length).toEqual 1

    describe 'liveEdit.save method', ->
        beforeEach ->
            compileElement(object, config.onSave, 'email')

            spyOn(element.ctrl, 'onSave').and.callThrough()
            element.ctrl.save()

        it 'should call on-save method from declaration', ->
            expect(element.ctrl.onSave).toHaveBeenCalledWith(object)

    describe 'startEditing method', ->
        beforeEach ->
            compileElement(object, config.onSave, 'email')
            spyOn(element.ctrl, 'reverseEditEnabled').and.callThrough()
            element.ctrl.startEditing()

        it 'should call reverseEditEnabled method', () ->
            expect(element.ctrl.reverseEditEnabled).toHaveBeenCalled()

        it 'should set focusInput to true', () ->
            expect(element.ctrl.focusInput).toBe(true)
