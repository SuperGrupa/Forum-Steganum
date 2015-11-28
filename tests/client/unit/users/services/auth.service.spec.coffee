describe 'Auth Service', ->
  authServ = {}
  mockedMeteor =
    requireValidUser: angular.noop
    requireUser: angular.noop
    logout: angular.noop
  mockedRootScope =
    currentUser:
      role: 'admin'
  mockedStateParams =
    section_id: 123
    topic_id: 456
  requireValidUserValue = 'somePromise'
  requireUserValue = 'someAnotherPromise'
  successCallBack = {}
  failCallBack = {}

  beforeEach module('users',
    $meteor: mockedMeteor,
    $rootScope: mockedRootScope,
    $stateParams: mockedStateParams
  )

  beforeEach inject(($injector) ->
    authServ = $injector.get('authServ')
  )

  beforeEach (done) ->
    spyOn(mockedMeteor, 'requireValidUser').and.returnValue(requireValidUserValue)
    spyOn(mockedMeteor, 'requireUser').and.returnValue(requireUserValue)
    done()

  it 'should initialize', ->
    expect(authServ).toBeDefined()


  describe 'hasRole method', ->
    it 'should return promise form requireValidUser method', () ->
      expect(authServ.hasRole()).toBe(requireValidUserValue)

    describe 'function in requireValidUser', ->
      it 'should return "UNAUTHORIZED" when role is different than argument', () ->
        authServ.hasRole('user')
        expect(mockedMeteor.requireValidUser.calls.argsFor(0)[0]()).toBe('UNAUTHORIZED')

      it 'should return true when role is same as argument', () ->
        authServ.hasRole('admin')
        expect(mockedMeteor.requireValidUser.calls.argsFor(0)[0]()).toBe(true)


  describe 'stateCan method', ->
    it 'should return promise form requireValidUser method', () ->
      expect(authServ.stateCan()).toBe(requireValidUserValue)

    describe 'function in requireValidUser', ->
      what = '\'s up?'
      name = 'nobody'
      returnedValue = null

      describe '@.can method return false', ->
        beforeEach (done) ->
          spyOn(authServ, 'can').and.returnValue false
          authServ.stateCan(what, name)
          returnedValue = mockedMeteor.requireValidUser.calls.argsFor(0)[0]()
          done()

        it 'should call can method on authServ with what and name', () ->
          expect(authServ.can).toHaveBeenCalledWith(what, name)

        it 'should return "UNAUTHORIZED"', () ->
          expect(returnedValue).toBe('UNAUTHORIZED')

      describe '@.can method return true', ->
        beforeEach (done) ->
          spyOn(authServ, 'can').and.returnValue true
          authServ.stateCan(what, name)
          returnedValue = mockedMeteor.requireValidUser.calls.argsFor(0)[0]()
          done()

        it 'should call can method on authServ with what and name', () ->
          expect(authServ.can).toHaveBeenCalledWith(what, name)

        it 'should return true', () ->
          expect(returnedValue).toBe(true)



  describe 'isLogged method', ->
    it 'should return promise form requireUser method', () ->
      expect(authServ.isLogged()).toBe(requireUserValue)


  describe 'isNotLogged method', ->
    returnedValue = null

    describe 'user exists', ->
      beforeEach (done) ->
        mockedRootScope.currentUser = 'someObject'
        returnedValue = authServ.isNotLogged()
        done()

      it 'should return failed promise', () ->
        expect(returnedValue.$$state.status).toBe 2


    describe 'user doesn\'t exist', ->
      beforeEach (done) ->
        mockedRootScope.currentUser = null
        returnedValue = authServ.isNotLogged()
        done()

      it 'should return failed promise', () ->
        expect(returnedValue.$$state.status).toBe 1


  describe 'can method', ->
    returnedValue = null

    describe 'user doesn\'t exist', ->
      beforeEach (done) ->
        mockedRootScope.currentUser = null
        done()

      it 'should return false', () ->
        expect(authServ.can()).toBe false

      it 'should return true when read section', () ->
        expect(authServ.can('read', 'section')).toBe true

    describe 'user exists', ->
      beforeEach (done) ->
        mockedRootScope.currentUser = {
          can: {}
        }
        done()

      it 'should return false', () ->
        expect(authServ.can()).toBe false

      describe 'and can do action', ->
        beforeEach (done) ->
          mockedRootScope.currentUser = {
            can:
              update:
                section: true
          }
          done()

        it 'should return true', () ->
          expect(authServ.can('update', 'section')).toBe true

      describe 'name = "post"', ->
        beforeEach (done) ->
          mockedRootScope.currentUser = {
            can:
              remove:
                post: false
                in:
                  topic: []
                  section: []
                self:
                  topic: false
                  section: false
          }
          done()

        it 'should return false', () ->
          expect(authServ.can('remove', 'post')).toBe false

        describe 'and can in topic', ->
          beforeEach (done) ->
            mockedRootScope.currentUser.can.remove.in.topic = [456]
            done()

          it 'should return true', () ->
            expect(authServ.can('remove', 'post')).toBe true

        describe 'and can in section', ->
          beforeEach (done) ->
            mockedRootScope.currentUser.can.remove.in.section = [123]
            done()

          it 'should return true', () ->
            expect(authServ.can('remove', 'post')).toBe true


      describe 'name = "topic"', ->
        beforeEach (done) ->
          mockedRootScope.currentUser = {
            can:
              create:
                topic: false
                in:
                  section: []
                self:
                  section: false
          }
          mockedStateParams = {}
          done()

        it 'should return false', () ->
          expect(authServ.can('create', 'topic')).toBe false

        describe 'and can in section', ->
          beforeEach (done) ->
            mockedRootScope.currentUser.can.create.in.section = [123]
            done()

          it 'should return true', () ->
            expect(authServ.can('create', 'topic')).toBe true

      describe 'can in self section', ->
        beforeEach (done) ->
          mockedRootScope.currentUser = {
            can:
              read:
                section: false
                self:
                  section: true
            _id: 890
          }
          done()

        it 'should return false when id is different', () ->
          expect(authServ.can('read', 'section', { userId: 456 })).toBe false

        it 'should return true when id is the same', () ->
          expect(authServ.can('read', 'section', { userId: 890 })).toBe true




