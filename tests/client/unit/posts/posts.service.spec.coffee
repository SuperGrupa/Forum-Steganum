describe 'Posts Service', ->
  postsServ = {}
  mockedMeteor =
    call: angular.noop
    object: angular.noop
    collection: angular.noop
  mockedAlertsServ =
    success: angular.noop
    error: angular.noop
  callBack = {}
  successCallBack = {}
  failCallBack = {}

  beforeEach ->
    spyOn(mockedMeteor, 'call').and.returnValue
      then: (success, fail) ->
          successCallBack = success
          failCallBack = fail
    spyOn(mockedMeteor, 'object').and.callFake ->
      subscribe: (what) ->
        callBack = what
    spyOn(mockedMeteor, 'collection').and.callFake ->
      subscribe: (what) ->
        callBack = what
    spyOn(mockedAlertsServ, 'success')
    spyOn(mockedAlertsServ, 'error')

  beforeEach module('posts',
    $meteor: mockedMeteor
    alertsServ: mockedAlertsServ
  )

  beforeEach inject(($injector) ->
    postsServ = $injector.get('postsServ')
  )

  it 'should initialize', ->
    expect(postsServ).toBeDefined()

  describe 'add method', ->
    newPost = 'something'
    error = 'You\'ve trusted someone!'

    beforeEach ->
      postsServ.add(newPost)

    it 'should call call method on meteor with "addPost" and newPost', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('addPost', newPost)

    describe 'successCallBack', ->
      it 'should call success method on alertsServ', () ->
        successCallBack()
        expect(mockedAlertsServ.success).toHaveBeenCalled()

    describe 'failCallBack', ->
      it 'should call error method on alertsServ with error', ->
        failCallBack(error)
        expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)

  describe 'delete method', ->
    post =
      id: 'someId'
    error = 'You\'ve trusted someone!'

    beforeEach ->
      postsServ.delete(post)

    it 'should call call method on meteor with "addPost" and postId', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('deletePost', post.id)

    describe 'successCallBack', ->
      it 'should call success method on alertsServ', () ->
        successCallBack()
        expect(mockedAlertsServ.success).toHaveBeenCalled()

    describe 'failCallBack', ->
      it 'should call error method on alertsServ with error', ->
        failCallBack(error)
        expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)

  describe 'update method', ->
    post =
      id: 'someId'
      text: 'someText'
    error = 'You\'ve trusted someone!'

    beforeEach ->
      postsServ.update(post)

    it 'should call call method on meteor with "updatePost" and postId', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('updatePost', post.id, post.text)

    describe 'successCallBack', ->
      it 'should call success method on alertsServ', () ->
        successCallBack()
        expect(mockedAlertsServ.success).toHaveBeenCalled()

    describe 'failCallBack', ->
      it 'should call error method on alertsServ with error', ->
        failCallBack(error)
        expect(mockedAlertsServ.error).toHaveBeenCalledWith(error)

  describe 'findOwner method', ->
    post =
      id: 'someId'
      userId: 'someUserId'
      text: 'someText'

    beforeEach ->
      postsServ.findOwner(post)

    it 'should call $meteor.object method with Meteor.users, post.userId and false arguments', ->
        expect(mockedMeteor.object).toHaveBeenCalledWith(Meteor.users, post.userId, false)
