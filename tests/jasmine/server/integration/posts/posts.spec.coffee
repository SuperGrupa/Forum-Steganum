describe 'Posts', ->
    post =
        text: 'Some example text'
        topic_id: '1'
        userId: '1'

    describe 'addPost Meteor method', ->
        posts_before_add = 0
        login = ->
            spyOn(Meteor, 'userId').and.returnValue('1')

        beforeEach ->
            posts_before_add = Posts.find().count()

        it 'should throw not-authorized error', ->
            Meteor.call 'addPost', post, (error) ->
                expect(error).toEqual(new Meteor.Error('not-authorized'))

        it 'should add new post to database', ->
            login()
            Meteor.call 'addPost', post
            expect(Posts.find().count()).toEqual(posts_before_add + 1)
            expect(Posts.find({ userId: '1' }).count()).toBe(1)

        # clear Posts collection
        Posts.remove { }
