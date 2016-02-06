describe 'Topics Service', ->
    topicsServ = {}
    collectionCallBack = {}
    subscribeArguments = {}
    topic =
        section_id: '1'
        name: 'Some topic'
        description: 'Some description'
    mockedMeteor =
        call: angular.noop
        collection: (callBack) ->
            collectionCallBack = callBack
            return subscribe: (name, topicId, pageNumber, postsPerPage) ->
                subscribeArguments =
                    first: name
                    second: topicId
                    third: pageNumber
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
        spyOn(Filter.Posts, 'by')
        spyOn(mockedState, 'go')
        spyOn(mockedState, 'goBack')
        spyOn(mockedAlertsServ, 'success')
        spyOn(mockedAlertsServ, 'error')

    beforeEach module('topics',
        $meteor: mockedMeteor
        $state: mockedState
        alertsServ: mockedAlertsServ
    )

    beforeEach inject ($injector) ->
        topicsServ = $injector.get('topicsServ')

    it 'should initialize', ->
        expect(topicsServ).toBeDefined()

    describe 'getPostsWithImages method', ->
        topic_id = 1
        page_number = 2

        beforeEach ->
            topicsServ.getPostsWithImages(topic_id, page_number)
            collectionCallBack()

        it 'should call by method on Filter.Posts with proper arguments', ->
            expect(Filter.Posts.by).toHaveBeenCalledWith topic_id,
                sort: createdAt: -1
                limit: 10*page_number

        it 'should call subscribe method on $meteor.collection object with proper arguments', ->
            expect(subscribeArguments).toEqual
                first: 'postsOfTopic'
                second: topic_id
                third: page_number

    describe 'getTopicById method', ->
        beforeEach ->
            topicsServ.getTopicById(1)

        it 'should call getTopicById method on $meteor.call with topic_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('getTopicById', 1)

    describe 'create method', ->
        error = 'Earth doesn\'t exist anymore'

        beforeEach ->
            topicsServ.create(topic)

        it 'should call addTopic method on $meteor.call with topic', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('addTopic', topic)


        describe 'successCallBack', ->
            beforeEach (done) ->
                successCallBack()
                done()

            it 'should call success method on alertsServ', () ->
                expect(mockedAlertsServ.success).toHaveBeenCalled()

            it 'should call go method on $state on successCallBack', () ->
                expect(mockedState.go).toHaveBeenCalledWith('section.one.show', id: topic.section_id)

        describe 'failCallBack', ->
            it 'should call error method on alertsServ with error', ->
                failCallBack(error)
                expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)


    describe 'update method', ->
        error = 'Earth doesn\'t exist anymore'

        beforeEach ->
            topic.name = 'Updated name'
            topic.description = 'Updated description'

            topicsServ.update(topic)

        it 'should call updateTopic method on $meteor.call with topic', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('updateTopic', topic)

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
        error = 'Earth doesn\'t exist anymore'

        beforeEach ->
            topicsServ.delete('1')
            successCallBack()

        it 'should call deleteTopic method on $meteor.call with topic_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('deleteTopic', '1')

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

