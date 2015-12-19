describe 'Alerts Service', ->
  alertsServ = {}
  mockedToastr = new TestServ()

  beforeEach module('common',
    toastr: mockedToastr
  )

  beforeEach (done) ->
    alertsServ = new TestServ('alertsServ')
    mockedToastr.addMethod 'success'
    mockedToastr.addMethod 'error'
    mockedToastr.addMethod 'warning'
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

  it 'should initialize', ->
    expect(alertsServ).toBeDefined()

  describe 'warning method', ->
    message = 'I can get no'
    title = 'satisfaction'

    beforeEach (done) ->
      alertsServ.warning(title, message)
      done()

    it 'should call succcess method on toastr with message and title', () ->
      expect(mockedToastr.warning).toHaveBeenCalledWith(message, title)
