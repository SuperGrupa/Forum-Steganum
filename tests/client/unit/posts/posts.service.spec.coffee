describe 'Posts Service', ->
  postsServ = {}
  mockedMeteor = {
    call: angular.noop
    object: angular.noop
    collection: angular.noop
  }
  callBack = {}

  beforeEach ->
    spyOn(mockedMeteor, 'call').and.returnValue true
    spyOn(mockedMeteor, 'object').and.callFake ->
      subscribe: (what) ->
        callBack = what
    spyOn(mockedMeteor, 'collection').and.callFake ->
      subscribe: (what) ->
        callBack = what

  beforeEach module('posts',
    $meteor: mockedMeteor
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

    it 'should call call method on meteor with "addPost" and newPost', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('addPost', newPost)

  describe 'delete method', ->
    post =
      _id: 'someId'
    beforeEach ->
      postsServ.delete(post)

    it 'should call call method on meteor with "addPost" and postId', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('deletePost', post._id)

  describe 'update method', ->
    post =
      _id: 'someId'
      text: 'someText'
    beforeEach ->
      postsServ.update(post)

    it 'should call call method on meteor with "addPost" and postId', ->
      expect(mockedMeteor.call).toHaveBeenCalledWith('updatePost', post._id, post.text)

  describe 'findOwner method', ->
    post =
      _id: 'someId'
      userId: 'someUserId'
      text: 'someText'

    beforeEach ->
      postsServ.findOwner(post)

    it 'should call $meteor.object method with Meteor.users, post.userId and false arguments', ->
        expect(mockedMeteor.object).toHaveBeenCalledWith(Meteor.users, post.userId, false)
