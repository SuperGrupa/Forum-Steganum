Helpers = require 'Helpers'

roleName = 'user'

updateUser = (canObject) ->
    Meteor.users.update({ role: roleName }, {$set:{'can': canObject}})

describe 'Auth', ->
    post =
        text: 'Some example text'
        topic_id: '1'
        userId: '1'
    topic =
        title: 'some title'
        section_id: '2'

    describe 'logging', ->
        it 'should throw notLogged error when userdId = undefined', ->
            Meteor.userId = -> undefined
            Meteor.call 'addPost', post, (error) ->
                expect(error).toEqual(new Meteor.Error('notLogged'))

    describe 'can\'t do anything', ->
        beforeEach (done) ->
            updateUser
                create:
                    post: false
                    in:
                        topic: []
                        section: []
                    self:
                        post: false
            Helpers.login(roleName)
            done()

        it 'should throw notAuthorized error', ->
            Meteor.call 'addPost', post, (error) ->
                expect(error).toEqual(new Meteor.Error('notAuthorized'))

    describe 'can add post', ->
        beforeEach (done) ->
            updateUser
                create:
                    post: true
            Helpers.login(roleName)
            done()

        it 'should add new post to database', ->
            Meteor.call 'addPost', post, (error) ->
                expect(error).not.toEqual(new Meteor.Error('notAuthorized'))
            Posts.remove { }

    describe 'can add post in topic', ->
        beforeEach (done) ->
            updateUser
                create:
                    post: false
                    in:
                        topic: ['1']
                        section: []
                    self:
                        post: false
            Helpers.login(roleName)
            done()

        it 'should add new post to database', ->
            Meteor.call 'addPost', post, (error) ->
                expect(error).not.toEqual(new Meteor.Error('notAuthorized'))
            Posts.remove { }

    describe 'can add post in section', ->
        topicId = null

        beforeEach (done) ->
            Helpers.seed.topic
                section_id: '2'
                name: 'some name'
            topicId = Topics.findOne({ name: 'some name' }).id
            updateUser
                create:
                    post: false
                    in:
                        topic: []
                        section: ['2']
                    self:
                        post: false
            Helpers.login(roleName)
            done()

        it 'should add new post to database', ->
            post.topic_id = topicId
            Meteor.call 'addPost', post, (error) ->
                expect(error).not.toEqual(new Meteor.Error('notAuthorized'))
            Posts.remove { }
            Topics.remove { }

    describe 'can update post in self', ->
        local_post = null

        beforeEach (done) ->
            Helpers.login(roleName)
            Helpers.seed.post
                text: 'some text'
            local_post = Posts.findOne({ text: 'some text' })
            updateUser
                create:
                    post: false
                    in:
                        topic: []
                        section: []
                    self:
                        post: true
            done()

        it 'should update post to database', ->
            Meteor.call 'updatePost', local_post.id, 'Some updated text', (error) ->
                expect(error).not.toEqual(new Meteor.Error('notAuthorized'))
            Posts.remove { }


    describe 'can add topic in section', ->
        topicId = null

        beforeEach (done) ->
            Helpers.seed.topic
                section_id: '2'
                name: 'some name'
            updateUser
                create:
                    topic: false
                    in:
                        topic: []
                        section: ['2']
                    self:
                        topic: false
            Helpers.login(roleName)
            done()

        it 'should add new post to database', ->
            Meteor.call 'addTopic', topic, (error) ->
                expect(error).not.toEqual(new Meteor.Error('notAuthorized'))
            Topics.remove { }
