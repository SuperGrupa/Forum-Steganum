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
    failCallBack = {}

    beforeEach ->
        spyOn(mockedMeteor, 'call').and.returnValue
            then: (success, error) ->
                successCallBack = success
                failCallBack = error
        spyOn(Filter.Topics.by, 'section')
        spyOn(mockedState, 'go')
        spyOn(mockedState, 'goBack')
        spyOn(mockedAlertsServ, 'success')
        spyOn(mockedAlertsServ, 'error')

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

    describe 'create method', ->
        error = 'It\'s over 9000!'

        beforeEach ->
            section.name = 'New name'
            section.description = 'New description'

            sectionsServ.create(section)

        it 'should call addSection method on $meteor.call with section', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('addSection', section)

        describe 'successCallBack', ->
            beforeEach (done) ->
                successCallBack()
                done()

            it 'should call success method on alertsServ', () ->
                expect(mockedAlertsServ.success).toHaveBeenCalled()

            it 'should call go method on $state on successCallBack', () ->
                expect(mockedState.go).toHaveBeenCalledWith('section.list')

        describe 'failCallBack', ->
            it 'should call error method on alertsServ with error', ->
                failCallBack(error)
                expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)


    describe 'update method', ->
        error = 'It\'s over 9000!'

        beforeEach ->
            section.name = 'Updated name'
            section.description = 'Updated description'

            sectionsServ.update(section)

        it 'should call updateSection method on $meteor.call with section', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('updateSection', section)

        describe 'successCallBack', ->
            beforeEach (done) ->
                successCallBack()
                done()

            it 'should call success method on alertsServ', () ->
                expect(mockedAlertsServ.success).toHaveBeenCalled()

            it 'should call goBack method on $state on successCallBack', () ->
                expect(mockedState.goBack).toHaveBeenCalled()

        describe 'failCallBack', ->
            it 'should call error method on alertsServ with error', ->
                failCallBack(error)
                expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)

    describe 'delete method', ->
        error = 'It\'s over 9000!'

        beforeEach ->
            sectionsServ.delete('1')

        it 'should call deleteSection method on $meteor.call with section_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('deleteSection', '1')

        describe 'successCallBack', ->
            beforeEach (done) ->
                successCallBack()
                done()

            it 'should call success method on alertsServ', () ->
                expect(mockedAlertsServ.success).toHaveBeenCalled()

            it 'should call goBack method on $state on successCallBack', () ->
                expect(mockedState.goBack).toHaveBeenCalled()

        describe 'failCallBack', ->
            it 'should call error method on alertsServ with error', ->
                failCallBack(error)
                expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)

