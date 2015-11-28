describe 'Alerts Service', ->
  alertsServ = {}
  mockedToastr = {
    success: angular.noop,
    error: angular.noop
  }

  beforeEach module('common',
    toastr: mockedToastr
  )

  beforeEach inject(($injector) ->
    alertsServ = $injector.get('alertsServ')
  )

  beforeEach (done) ->
    spyOn(mockedToastr, 'success').and.returnValue true
    spyOn(mockedToastr, 'error').and.returnValue true
    done()

  it 'should initialize', ->
    expect(alertsServ).toBeDefined()

  describe 'success method', ->
    message = 'Trust no one'
    title = 'Batman'

    beforeEach (done) ->
      alertsServ.success(title, message)
      done()

    it 'should call succcess method on toastr with message and title', () ->
      expect(mockedToastr.success).toHaveBeenCalledWith(message, title)


  describe 'error method', ->
    error =
      error: 'notLogged'

    beforeEach (done) ->
      alertsServ.error(error)
      done()

    it 'should call error method on toastr with proper message and title', () ->
      expect(mockedToastr.error).toHaveBeenCalledWith('You are not logged in', 'Error')
