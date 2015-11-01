describe 'Topics Service', ->
    topicsServ = { }
    topic =
        section_id: '1'
        name: 'Some topic'
        description: 'Some description'
    mockedMeteor =
        call: angular.noop
        object: angular.noop
        collection: angular.noop

    callBack = { }

    beforeEach ->
        spyOn(mockedMeteor, 'call').and.returnValue Promise
        spyOn(mockedMeteor, 'collection').and.callFake ->
            subscribe: (what) ->
                callBack = what

    beforeEach module('topics', $meteor: mockedMeteor)

    beforeEach inject ($injector) ->
        topicsServ = $injector.get('topicsServ')

    it 'should initialize', ->
        expect(topicsServ).toBeDefined()

    describe 'getPosts method', ->
        beforeEach ->
            topicsServ.getPosts(1, 1, 10)

        it 'should call collection method on $meteor object', ->
            expect(mockedMeteor.collection).toHaveBeenCalled()

        it 'should call subscribe method on $meteor.collection object', ->
            expect(callBack).toEqual('postsOfTopic')

    describe 'getTopicById method', ->
        beforeEach ->
            topicsServ.getTopicById(1)

        it 'should call getTopicById method on $meteor.call with topic_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('getTopicById', 1)

    describe 'create method', ->
        beforeEach ->
            topicsServ.create(topic)

        it 'should call addTopic method on $meteor.call with topic', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('addTopic', topic)

    describe 'update method', ->
        beforeEach ->
            topic.name = 'Updated name'
            topic.description = 'Updated description'

            topicsServ.update(topic)

        it 'should call updateTopic method on $meteor.call with topic', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('updateTopic', topic)

    describe 'delete method', ->
        beforeEach ->
            topicsServ.delete('1')

        it 'should call deleteTopic method on $meteor.call with topic_id', ->
            expect(mockedMeteor.call).toHaveBeenCalledWith('deleteTopic', '1')
