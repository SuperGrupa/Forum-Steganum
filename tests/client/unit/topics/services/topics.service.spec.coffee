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
                    fourth: postsPerPage
    mockedState =
        go: angular.noop
        goBack: angular.noop
    successCallBack = {}

    beforeEach ->
        spyOn(mockedMeteor, 'call').and.returnValue
            then: (success) ->
                successCallBack = success
        spyOn(Filter.Posts, 'by')
        spyOn(mockedState, 'go')
        spyOn(mockedState, 'goBack')

    beforeEach module('topics',
        $meteor: mockedMeteor
        $state: mockedState
    )

    beforeEach inject ($injector) ->
        topicsServ = $injector.get('topicsServ')

    it 'should initialize', ->
        expect(topicsServ).toBeDefined()

    describe 'getPosts method', ->
        topic_id = 1
        page_number = 2
        posts_per_page = 10

        beforeEach ->
            topicsServ.getPosts(topic_id, page_number, posts_per_page)
            collectionCallBack()

        it 'should call by method on Filter.Posts with proper arguments', ->
            expect(Filter.Posts.by).toHaveBeenCalledWith(topic_id, page_number, posts_per_page)

        it 'should call subscribe method on $meteor.collection object with proper arguments', ->
            expect(subscribeArguments).toEqual
                first: 'postsOfTopic'
                second: topic_id
                third: page_number
                fourth: posts_per_page

    describe 'getTopicById method', ->
        beforeEach ->
            topicsServ.getTopicById(1)

        it 'should call getTopicById method on $meteor.call with topic_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('getTopicById', 1)

    describe 'create method', ->
        beforeEach ->
            topicsServ.create(topic)
            successCallBack()

        it 'should call addTopic method on $meteor.call with topic', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('addTopic', topic)

        it 'should call go method on $state on successCallBack', () ->
            expect(mockedState.go).toHaveBeenCalledWith('section.one.show', id: topic.section_id)

    describe 'update method', ->
        beforeEach ->
            topic.name = 'Updated name'
            topic.description = 'Updated description'

            topicsServ.update(topic)
            successCallBack()

        it 'should call updateTopic method on $meteor.call with topic', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('updateTopic', topic)

        it 'should call goBack method on $state on successCallBack', () ->
            expect(mockedState.goBack).toHaveBeenCalled()

    describe 'delete method', ->
        beforeEach ->
            topicsServ.delete('1')
            successCallBack()

        it 'should call deleteTopic method on $meteor.call with topic_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('deleteTopic', '1')

        it 'should call goBack method on $state on successCallBack', () ->
            expect(mockedState.goBack).toHaveBeenCalled()
