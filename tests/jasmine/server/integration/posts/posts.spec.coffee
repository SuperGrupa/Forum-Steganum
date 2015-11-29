Helpers = require 'Helpers'

describe 'Posts', ->
    post =
        text: 'Some example text'
        topic_id: '1'
        userId: '1'
    posts_before = 0

    beforeEach ->
        Helpers.clear()

    describe 'addPost method', ->
        it 'should throw not-authorized error', ->
            Helpers.logout()
            Meteor.call 'addPost', post, (error) ->
                expect(error).toEqual(new Meteor.Error('not-authorized'))

        it 'should add new post to database', ->
            Helpers.login()
            posts_before = Posts.find({}).count()
            Meteor.call 'addPost', post
            expect(Posts.find({}).count()).toEqual(posts_before + 1)
            expect(Posts.find({ text: 'Some example text' }).count()).toBeGreaterThan(0)

    describe 'deletePost method', ->
        beforeEach ->
            spyOn(Images, 'remove').and.returnValue true

        it 'should remove specific post (without image)', ->
            Helpers.seed.post(post)
            posts_before = Posts.find({}).count()

            local_post = Posts.findOne({ text: 'Some example text' })
            expect(local_post).not.toBe undefined

            Meteor.call 'deletePost', local_post.id
            expect(Posts.find({}).count()).toBe(posts_before - 1)
            expect(Images.remove).not.toHaveBeenCalled()

        it 'should remove specific post (with image)', ->
            post.image_id = '123'
            Helpers.seed.post(post)
            posts_before = Posts.find({}).count()

            local_post = Posts.findOne({ text: 'Some example text' })
            expect(local_post).not.toBe undefined

            Meteor.call 'deletePost', local_post.id
            expect(Posts.find({}).count()).toBe(posts_before - 1)
            expect(Images.remove).toHaveBeenCalled()

    describe 'updatePost method', ->
        beforeEach ->
            Helpers.seed.post(post)

        it 'should update post', ->
            posts_before = Posts.find({}).count()

            local_post = Posts.findOne({ text: 'Some example text' })
            Meteor.call 'updatePost', local_post.id, 'Some updated text'

            expect(Posts.find({}).count()).toBe(posts_before)

            updated_post = Posts.findOne({ id: local_post.id })
            expect(updated_post.text).toEqual('Some updated text')
            expect(updated_post.updatedAt).toBeGreaterThan(local_post.updatedAt)
