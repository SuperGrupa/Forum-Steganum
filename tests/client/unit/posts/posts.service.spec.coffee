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

  beforeEach ->
    spyOn(mockedMeteor, 'call').and.returnValue
      then: (success) ->
          successCallBack = success
    spyOn(mockedMeteor, 'object').and.callFake ->
      subscribe: (what) ->
        callBack = what
    spyOn(mockedMeteor, 'collection').and.callFake ->
      subscribe: (what) ->
        callBack = what

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
    beforeEach ->
      postsServ.add(newPost)
      successCallBack()

    it 'should call call method on meteor with "addPost" and newPost', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('addPost', newPost)

  describe 'delete method', ->
    post =
      id: 'someId'
    beforeEach ->
      postsServ.delete(post)
      successCallBack()

    it 'should call call method on meteor with "addPost" and postId', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('deletePost', post.id)

  describe 'update method', ->
    post =
      id: 'someId'
      text: 'someText'
    beforeEach ->
      postsServ.update(post)
      successCallBack()

    it 'should call call method on meteor with "updatePost" and postId', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('updatePost', post.id, post.text)

  describe 'findOwner method', ->
    post =
      id: 'someId'
      userId: 'someUserId'
      text: 'someText'

    beforeEach ->
      postsServ.findOwner(post)

    it 'should call $meteor.object method with Meteor.users, post.userId and false arguments', ->
        expect(mockedMeteor.object).toHaveBeenCalledWith(Meteor.users, post.userId, false)
