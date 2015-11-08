'use strict'

describe 'Directive: editTopic', ->
    element = {}
    mockedTopicsServ =
        getTopicById: angular.noop
    mockedSectionsServ =
        getSectionById: angular.noop
    mockedState =
        goBack: angular.noop
    mockedStateParams =
        topic_id: 1
        section_id: 2
    successSectionCallback = {}
    successTopicCallback = {}
    topic =
        title: 'Big Bang!'
    section =
        name: 'SuperNova'

    beforeEach module 'topics',
        topicsServ: mockedTopicsServ
        sectionsServ: mockedSectionsServ
        $state: mockedState
        $stateParams: mockedStateParams

    beforeEach (done) ->
        spyOn(mockedSectionsServ, 'getSectionById').and.returnValue
            then: (success) ->
                successSectionCallback = success
        spyOn(mockedTopicsServ, 'getTopicById').and.returnValue
            then: (success) ->
                successTopicCallback = success
        done()

    beforeEach module 'templates'

    beforeEach ->
        element = new TestElement 'editTopic'
        element.create '<edit-topic></edit-topic>'
        successSectionCallback(section)
        successTopicCallback(topic)

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should set $state to vm.state', () ->
        expect(element.ctrl.state).toBe(mockedState)

    it 'should call getTopicById method on topicsServ with topic_id', () ->
        expect(mockedTopicsServ.getTopicById).toHaveBeenCalledWith mockedStateParams.topic_id

    it 'should set result from topicsServ to vm.topic', () ->
        expect(element.ctrl.topic).toBe topic

    it 'should call getSectionById method on sectionsServ with section_id', () ->
        expect(mockedSectionsServ.getSectionById).toHaveBeenCalledWith mockedStateParams.section_id

    it 'should set result from sectionsServ to vm.section', () ->
        expect(element.ctrl.section).toBe section
