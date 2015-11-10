describe 'Topics', ->
    topic =
        section_id: '1'
        name: 'Example topic name'
        description: 'Description of example topic'

    describe 'addTopic method', ->
        it 'should throw not-authorized exception for not logged user', ->
            Helpers.logout()
            Meteor.call 'addTopic', topic, (error) ->
                Helpers.logout()
                expect(error).toEqual(new Meteor.Error('not-authorized'))

        it 'should add new topic after login', ->
            Helpers.login()
            topics_before = Topics.find({}).count()
            Meteor.call 'addTopic', topic
            expect(Topics.find({}).count()).toEqual(topics_before + 1)
            expect(Topics.find({ name: 'Example topic name' }).count()).toBeGreaterThan(0)

    describe 'updateTopic method', ->
        beforeEach ->
            Helpers.logout()

        it 'should update topic name and description in database', ->
            local_post = Topics.findOne({ name: 'Example topic name' })
            expect(local_post).not.toBe(undefined)

            local_post.name = 'Updated topic name'
            local_post.description = 'Updated description of example topic'

            Meteor.call 'updateTopic', local_post

            updated_topic = Topics.findOne({ id: local_post.id })
            expect(updated_topic).not.toBe(undefined)
            expect(updated_topic.name).toBe('Updated topic name')
            expect(updated_topic.description).toBe('Updated description of example topic')
            expect(updated_topic.updatedAt).toBeGreaterThan(local_post.updatedAt)

    describe 'deleteTopic method', ->
        beforeEach ->
            Helpers.clear()
            Helpers.seed.topic(topic)

        it 'should delete given topic', ->
            local_post_id = Topics.findOne({ name: 'Example topic name' }, { fields: { id: 1}})
            expect(local_post_id).not.toBe(undefined)

            Meteor.call 'deleteTopic', local_post_id
            Topics.remove({ })

            local_post_id = Topics.findOne({ name: 'Example topic name' }, { fields: { id: 1}})
            expect(local_post_id).toBe(undefined)

    describe 'getTopicById method', ->
        beforeEach ->
            Helpers.clear()
            Helpers.seed.topic(topic)

        it 'should return topic object based on given id', ->
            # znajdź pierwszy lepszy temat w bazie i pobierz go przez metodę
            topic_from_db = Topics.findOne({ name: 'Example topic name' })
            expect(topic_from_db).not.toBe(undefined)

            topic_from_method = Meteor.call 'getTopicById', topic_from_db.id

            expect(topic_from_db).toEqual(topic_from_method)
