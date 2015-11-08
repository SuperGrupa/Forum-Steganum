describe 'PageOfPosts controller', ->
    $scope = { }
    $controller = { }
    PageOfPostsCtrl = { }
    mockedTopicsServ =
        getPosts: angular.noop
    mockedStateParams =
        topic_id: 69
        section_id: 96
        page_number: 1
    posts = [
        'Post1'
        'Post2'
    ]

    beforeEach module 'forumSteganum'

    beforeEach (done) ->
        spyOn(mockedTopicsServ, 'getPosts').and.returnValue posts
        done()

    beforeEach inject ($injector) ->
        $controller = $injector.get('$controller')
        $scope = $injector.get('$rootScope').$new()
        PageOfPostsCtrl = $controller 'PageOfPostsCtrl',
            $scope: $scope
            topicsServ: mockedTopicsServ
            $stateParams: mockedStateParams

    it 'should initialize', ->
        expect(PageOfPostsCtrl).toBeDefined()

    it 'should call getPosts method on topicsServ with topic.id', ->
        expect(mockedTopicsServ.getPosts).toHaveBeenCalledWith(mockedStateParams.topic_id, mockedStateParams.page_number, 10)

    it 'should set result from topicsServ to topic.posts', () ->
        expect(PageOfPostsCtrl.topic.posts).toBe posts

    it 'set page_number from stateParams to vm.page_number', () ->
        expect(PageOfPostsCtrl.page_number).toBe mockedStateParams.page_number

    it 'set state params to vm.topic', () ->
        expect(PageOfPostsCtrl.topic.id).toBe mockedStateParams.topic_id
        expect(PageOfPostsCtrl.topic.section_id).toBe mockedStateParams.section_id

