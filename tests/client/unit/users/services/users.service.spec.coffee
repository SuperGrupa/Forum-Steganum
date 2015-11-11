describe 'Users Service', ->
  usersServ = {}
  mockedMeteor = {
    call: angular.noop
  }
  mockedToastr = {
    success: angular.noop,
    error: angular.noop
  }
  successCallBack = {}
  failCallBack = {}

  beforeEach module('users',
    $meteor: mockedMeteor,
    toastr: mockedToastr
  )

  beforeEach inject(($injector) ->
    usersServ = $injector.get('usersServ')
  )

  beforeEach (done) ->
    spyOn(mockedToastr, 'success').and.returnValue true
    spyOn(mockedToastr, 'error').and.returnValue true
    done()

  it 'should initialize', ->
    expect(usersServ).toBeDefined()



  describe 'updateEmail method', ->
    email = 'flash@man.pl'
    data =
      message: 'You are too fast, Flash!'

    beforeEach (done) ->
      spyOn(mockedMeteor, 'call').and.returnValue
        then: (success, fail) ->
          successCallBack = success
          failCallBack = fail
      done()

    describe 'success', ->
      beforeEach (done) ->
        usersServ.updateEmail(email)
        successCallBack()
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateEmail', email

      it 'should call go success on toastr', () ->
        expect(mockedToastr.success).toHaveBeenCalledWith 'Email updated successfully'

    describe 'failed', ->
      beforeEach (done) ->
        usersServ.updateEmail(email)
        failCallBack(data)
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateEmail', email

      it 'should call go error on toastr', () ->
        expect(mockedToastr.error).toHaveBeenCalledWith data.message, 'Error'


  describe 'updateEmail method', ->
    email = 'flash@man.pl'
    data =
      message: 'You are too fast, Flash!'

    beforeEach (done) ->
      spyOn(mockedMeteor, 'call').and.returnValue
        then: (success, fail) ->
          successCallBack = success
          failCallBack = fail
      done()

    describe 'success', ->
      beforeEach (done) ->
        usersServ.updateEmail(email)
        successCallBack()
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateEmail', email

      it 'should call go success on toastr', () ->
        expect(mockedToastr.success).toHaveBeenCalledWith 'Email updated successfully'

    describe 'failed', ->
      beforeEach (done) ->
        usersServ.updateEmail(email)
        failCallBack(data)
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateEmail', email

      it 'should call go error on toastr', () ->
        expect(mockedToastr.error).toHaveBeenCalledWith data.message, 'Error'



  describe 'updateUsername method', ->
    username = 'Joker'
    data =
      message: 'You are too funny, Joker!'

    beforeEach (done) ->
      spyOn(mockedMeteor, 'call').and.returnValue
        then: (success, fail) ->
          successCallBack = success
          failCallBack = fail
      done()

    describe 'success', ->
      beforeEach (done) ->
        usersServ.updateUsername(username)
        successCallBack()
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateUsername', username

      it 'should call go success on toastr', () ->
        expect(mockedToastr.success).toHaveBeenCalledWith 'Login updated successfully'

    describe 'failed', ->
      beforeEach (done) ->
        usersServ.updateUsername(username)
        failCallBack(data)
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateUsername', username

      it 'should call go error on toastr', () ->
        expect(mockedToastr.error).toHaveBeenCalledWith data.message, 'Error'



  describe 'updateProfile method', ->
    profile =
      firstname: 'Bruce'
      lastname: 'Banner'
    data =
      message: 'You are too strong, Hulk!'

    beforeEach (done) ->
      spyOn(mockedMeteor, 'call').and.returnValue
        then: (success, fail) ->
          successCallBack = success
          failCallBack = fail
      done()

    describe 'success', ->
      beforeEach (done) ->
        usersServ.updateProfile(profile)
        successCallBack()
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateProfile', profile

      it 'should call go success on toastr', () ->
        expect(mockedToastr.success).toHaveBeenCalledWith 'Profile updated successfully'

    describe 'failed', ->
      beforeEach (done) ->
        usersServ.updateProfile(profile)
        failCallBack(data)
        done()

      it 'should call loginWithPassword method on meteor', () ->
        expect(mockedMeteor.call).toHaveBeenCalledWith 'updateProfile', profile

      it 'should call go error on toastr', () ->
        expect(mockedToastr.error).toHaveBeenCalledWith data.message, 'Error'



