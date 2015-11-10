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
        Helpers.logout()

        it 'should update topic name and description in database', ->
            local_post = Topics.findOne({ name: 'Example topic name' })
            expect(local_post).not.toBe(null)

            local_post.name = 'Updated topic name'
            local_post.description = 'Updated description of example topic'

            Meteor.call 'updateTopic', local_post

            updated_topic = Topics.findOne({ id: local_post.id })
            expect(updated_topic).not.toBe(null)
            expect(updated_topic.name).toBe('Updated topic name')
            expect(updated_topic.description).toBe('Updated description of example topic')
            expect(updated_topic.updatedAt).toBeGreaterThan(local_post.updatedAt)
