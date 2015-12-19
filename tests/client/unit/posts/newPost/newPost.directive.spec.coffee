'use strict'

describe 'Directive: newPost', ->
    mockedPostsServ =
        add: angular.noop
    mockedAlertsServ =
        error: angular.noop
    mockedStateParams =
        topic_id: 123
    successCallback = {}

    beforeEach module 'posts',
        postsServ: mockedPostsServ
        alertsServ: mockedAlertsServ
        $stateParams: mockedStateParams
    beforeEach module 'templates'

    element = {}

    beforeEach (done) ->
        spyOn(mockedPostsServ, 'add').and.returnValue
            then: (success) ->
                successCallback = success
        done()

    beforeEach ->
        element = new TestElement()
        element.createDirective 'newPost', '<new-post></new-post>'

    it 'should compile', ->
        expect(element.dom).toBeDefined()

    it 'should set to vm.action', ->
        expect(element.ctrl.action).toBe(mockedPostsServ)

    describe 'clearPost method', ->
        beforeEach (done) ->
            element.ctrl.clearPost()
            done()

        it 'should clear text', () ->
            expect(element.ctrl.post.text).toBe ''

        it 'should set $stateParams.topic_id to post.topic_id', () ->
            expect(element.ctrl.post.topic_id).toBe mockedStateParams.topic_id

    describe 'addPost method success', ->
        post =
            text: 'Im Batman'
        image =
            name: 'Gotham_Night_Panorama.jpg'

        beforeEach (done) ->
            spyOn(element.ctrl, 'clearPost')
            element.ctrl.addPost(post, image)
            successCallback()
            done()

        it 'should call add method on postsServ with post', () ->
            expect(mockedPostsServ.add).toHaveBeenCalledWith(post, image)

        it 'should call clearPost method on controller', () ->
            expect(element.ctrl.clearPost).toHaveBeenCalled()

    describe 'addPost method failure', ->
        post =
            text: ''
        image =
            name: ''

        beforeEach (done) ->
            spyOn(element.ctrl, 'clearPost')
            element.ctrl.addPost(post, image)
            done()

        it 'should not call add method on postsServ', () ->
            expect(mockedPostsServ.add).not.toHaveBeenCalled()
            expect(element.ctrl.clearPost).not.toHaveBeenCalled()
