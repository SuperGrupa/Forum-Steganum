'use strict'

describe 'Directive: liveEdit', ->
    object =
        text: 'live edit value'
    onSave = angular.noop

    beforeEach module 'common'
    beforeEach module 'templates'

    element = { }

    beforeEach (done) ->
        done()

    compileElement = (objectName, onSave, inputType) ->
        element = new TestElement 'liveEdit'
        element.create '<live-edit object="object" on-save="onSave()" input-type="' + inputType + '"></live-edit>',
            object: object,
            onSave: onSave

    describe 'compilation', ->
        beforeEach ->
            compileElement(object, onSave, 'password')

        it 'should compile', ->
            expect(element.dom).toBeDefined()
            expect(element.ctrl).toBeDefined()

        it 'should have its own object copy', ->
            expect(element.ctrl.object).toEqual object
            expect(element.ctrl.object).not.toBe object

    describe 'HTML template structure', ->
        beforeEach (done) ->
            compileElement(object, onSave, 'password')
            done()

        it 'should have visible object.text', ->
            expect(element.dom.find('[ng-hide="live.editEnabled"]').hasClass('ng-hide')).toBeFalsy

        it 'should have hidden input', ->
            expect(element.dom.find('[ng-show="live.editEnabled"]').hasClass('ng-hide')).toBeTruthy

    describe 'textarea or input?', ->
        it 'should have input with type email', ->
            compileElement(object, onSave, 'email')
            expect(element.dom.find('input[type=email]').length).toEqual 1
            expect(element.dom.find('textarea').length).toEqual 0

        it 'should have textarea instead of input', ->
            compileElement(object, onSave, 'text')
            expect(element.dom.find('input[type=email]').length).toEqual 0
            expect(element.dom.find('textarea').length).toEqual 1


        # it 'have hidden section.name', () ->
        #     expect(element.dom.find('[ng-show="nav.sectionId"]').hasClass('ng-hide')).toBeTruthy()
        #
        # it 'have hidden topic.name', () ->
        #     expect(element.dom.find('[ng-show="nav.topicId"]').hasClass('ng-hide')).toBeTruthy()
        #
    # describe 'with section id', ->
    #     sectionId = '2'
    #
    #     beforeEach (done) ->
    #         compileElement(sectionId, '')
    #         successCallback()
    #         element.scope.$digest()
    #         done()
    #
    #     it 'should call call method on $meteor with "getSectionById" and sectionId', () ->
    #         expect(mockedMeteor.call).toHaveBeenCalledWith('getSectionById', sectionId)
    #
    #     it 'should show section.name', () ->
    #         expect(element.dom.find('[ng-show="nav.sectionId"]').text()).toContain section.name
    #
    #     it 'have hidden topic.name', () ->
    #         expect(element.dom.find('[ng-show="nav.topicId"]').hasClass('ng-hide')).toBeTruthy()
    #
    # describe 'with topic id', ->
    #     topicId = '3'
    #
    #     beforeEach (done) ->
    #         compileElement('', topicId)
    #         successCallback()
    #         element.scope.$digest()
    #         done()
    #
    #     it 'should call call method on $meteor with "getTopicById" and topicId', () ->
    #         expect(mockedMeteor.call).toHaveBeenCalledWith('getTopicById', topicId)
    #
    #     it 'have hidden section.name', () ->
    #         expect(element.dom.find('[ng-show="nav.sectionId"]').hasClass('ng-hide')).toBeTruthy()
    #
    #     it 'should show topic.name', () ->
    #         expect(element.dom.find('[ng-show="nav.topicId"]').text()).toContain topic.name
