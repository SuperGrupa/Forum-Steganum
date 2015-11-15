describe 'Sections Service', ->
    sectionsServ = {}
    collectionCallBack = {}
    subscribeArguments = {}
    section =
        name: 'Some section'
        description: 'Some description'
    mockedMeteor =
        call: angular.noop
        collection: (callBack) ->
            collectionCallBack = callBack
            return subscribe: (name, topicId) ->
                subscribeArguments =
                    first: name
                    second: topicId
    mockedState =
        go: angular.noop
        goBack: angular.noop
    mockedAlertsServ = 
        success: angular.noop
        error: angular.noop
    successCallBack = {}

    beforeEach ->
        spyOn(mockedMeteor, 'call').and.returnValue
            then: (success) ->
                successCallBack = success
        spyOn(Filter.Topics.by, 'section')
        spyOn(mockedState, 'go')
        spyOn(mockedState, 'goBack')

    beforeEach module('sections',
        $meteor: mockedMeteor
        $state: mockedState
        alertsServ: mockedAlertsServ
    )

    beforeEach inject ($injector) ->
        sectionsServ = $injector.get('sectionsServ')

    it 'should initialize', ->
        expect(sectionsServ).toBeDefined()

    describe 'all property', ->
        beforeEach (done) ->
            sectionsServ.all
            done()

        it 'should call subscribe method on $meteor.collection object with proper arguments', ->
            expect(subscribeArguments).toEqual
                first: 'sections'
                second: undefined

    describe 'getTopics method', ->
        section_id = 1

        beforeEach ->
            sectionsServ.getTopics(section_id)
            collectionCallBack()

        it 'should call by method on Filter.Posts with proper arguments', ->
            expect(Filter.Topics.by.section).toHaveBeenCalledWith(section_id)

        it 'should call subscribe method on $meteor.collection object with proper arguments', ->
            expect(subscribeArguments).toEqual
                first: 'topicsInSection'
                second: section_id

    describe 'getSectionById method', ->
        beforeEach ->
            sectionsServ.getSectionById(1)

        it 'should call getSectionById method on $meteor.call with section_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('getSectionById', 1)

    describe 'update method', ->
        beforeEach ->
            section.name = 'Updated name'
            section.description = 'Updated description'

            sectionsServ.update(section)
            successCallBack()

        it 'should call updateSection method on $meteor.call with section', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('updateSection', section)

        it 'should call goBack method on $state on successCallBack', () ->
            expect(mockedState.goBack).toHaveBeenCalled()

    describe 'delete method', ->
        beforeEach ->
            sectionsServ.delete('1')
            successCallBack()

        it 'should call deleteSection method on $meteor.call with section_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('deleteSection', '1')

        it 'should call goBack method on $state on successCallBack', () ->
            expect(mockedState.goBack).toHaveBeenCalled()
