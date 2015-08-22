describe 'Posts Service', ->
  postsServ = {}
  mockedMeteor = {
    call: angular.noop
    collection: angular.noop
  }
  callBack = {}

  beforeEach ->
    spyOn(mockedMeteor, 'call').and.returnValue true
    spyOn(mockedMeteor, 'collection').and.callFake ->
      subscribe: (what) ->
        callBack = what


  beforeEach module('posts',
    $meteor: mockedMeteor)


  beforeEach inject(($injector) ->
    postsServ = $injector.get('postsServ')
  )


  it 'should initialize', ->
    expect(postsServ).toBeDefined()

  it 'should call collection method on $meteor', ->
    expect(mockedMeteor.collection).toHaveBeenCalled()

  it 'should call subcribe method on $meteor.collection with "posts"', ->
    expect(callBack).toBe('posts')

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
