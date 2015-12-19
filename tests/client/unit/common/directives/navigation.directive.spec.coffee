'use strict'

describe 'Directive: navigation', ->
    mockedMeteor =
        call: angular.noop
    successCallback = {}
    section =
        name: 'district 9'
    topic =
        name: 'best topic ever'

    beforeEach module 'common',
        $meteor: mockedMeteor
    beforeEach module 'templates'

    element = {}

    beforeEach (done) ->
        spyOn(mockedMeteor, 'call').and.returnValue
            then: (success) ->
                successCallback = success

        spyOn(Filter.Sections, 'by').and.returnValue section
        spyOn(Filter.Topics.by, 'id').and.returnValue topic
        done()

    compileElement = (sectionId, topicId) ->
        element = new TestElement()
        element.createDirective 'navigation', '<navigation section-id="' + sectionId + '" topic-id="' + topicId + '"></navigation>'

    describe 'without ids', ->
        beforeEach (done) ->
            compileElement('', '')
            done()

        it 'have hidden section.name', () ->
            expect(element.dom.find('[ng-show="nav.sectionId"]').hasClass('ng-hide')).toBeTruthy()

        it 'have hidden topic.name', () ->
            expect(element.dom.find('[ng-show="nav.topicId"]').hasClass('ng-hide')).toBeTruthy()

    describe 'with section id', ->
        sectionId = '2'

        beforeEach (done) ->
            compileElement(sectionId, '')
            successCallback()
            element.scope.$digest()
            done()

        it 'should call call method on $meteor with "getSectionById" and sectionId', () ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('getSectionById', sectionId)

        it 'should show section.name', () ->
            expect(element.dom.find('[ng-show="nav.sectionId"]').text()).toContain section.name

        it 'have hidden topic.name', () ->
            expect(element.dom.find('[ng-show="nav.topicId"]').hasClass('ng-hide')).toBeTruthy()

    describe 'with topic id', ->
        topicId = '3'

        beforeEach (done) ->
            compileElement('', topicId)
            successCallback()
            element.scope.$digest()
            done()

        it 'should call call method on $meteor with "getTopicById" and topicId', () ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('getTopicById', topicId)

        it 'have hidden section.name', () ->
            expect(element.dom.find('[ng-show="nav.sectionId"]').hasClass('ng-hide')).toBeTruthy()

        it 'should show topic.name', () ->
            expect(element.dom.find('[ng-show="nav.topicId"]').text()).toContain topic.name

