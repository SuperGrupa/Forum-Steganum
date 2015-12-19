describe 'PageOfPosts controller', ->
    $scope = { }
    $controller = { }
    PageOfPostsCtrl = { }
    mockedTopicsServ =
        getPostsWithImages: angular.noop
    mockedStateParams =
        topic_id: 69
        section_id: 96
        page_number: 1
    posts = [
        ['Image1', null],
        ['Post1', 'Post2']
    ]

    beforeEach module 'topics'

    beforeEach (done) ->
        spyOn(mockedTopicsServ, 'getPostsWithImages').and.returnValue posts
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

    it 'should call getPostsWithImages method on topicsServ with topic.id', ->
        expect(mockedTopicsServ.getPostsWithImages).toHaveBeenCalledWith(mockedStateParams.topic_id, mockedStateParams.page_number, 10)

    it 'should set result from topicsServ to topic.posts', () ->
        # wyjaśnienie: getPostsWithImages zwraca tablicę - pierwszym elementem są obrazki, a drugim posty
        expect(PageOfPostsCtrl.topic.posts).toBe posts[1]

    it 'set page_number from stateParams to vm.page_number', () ->
        expect(PageOfPostsCtrl.page_number).toBe mockedStateParams.page_number

    it 'set state params to vm.topic', () ->
        expect(PageOfPostsCtrl.topic.id).toBe mockedStateParams.topic_id
        expect(PageOfPostsCtrl.topic.section_id).toBe mockedStateParams.section_id
