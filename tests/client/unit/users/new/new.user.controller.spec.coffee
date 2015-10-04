describe 'Login controller', ->
  $scope = {}
  $controller = {}
  NewUserCtrl = {}
  mockedAuthServ = {}
  initEmail = 'super@man.pl'
  initName = 'ClarkKent'

  beforeEach module('forumSteganum')

  beforeEach inject(($injector) ->
    $controller = $injector.get('$controller')
    $scope = $injector.get('$rootScope').$new()
    mockedAuthServ = {
      email: initEmail
      userName: initName
    }
    NewUserCtrl = $controller('NewUserCtrl as nUCtrl',
      $scope: $scope
      authServ: mockedAuthServ
    )
  )

  it 'should initialize', ->
    expect(NewUserCtrl).toBeDefined()

  describe 'updateLogin method', ->
    describe 'with email and not dirty', ->
      beforeEach (done) ->
        NewUserCtrl.regForm = {
          userName:
            $dirty: false
        }
        NewUserCtrl.updateLogin()
        done()

      it 'should not change authServ.userName', () ->
        expect(mockedAuthServ.userName).toBe initEmail.split("@").shift()

    describe 'no email', ->
      beforeEach (done) ->
        mockedAuthServ.email = ''
        NewUserCtrl.regForm = {
          userName:
            $dirty: false
        }
        NewUserCtrl.updateLogin()
        done()

      it 'should not change authServ.userName', () ->
        expect(mockedAuthServ.userName).toBe initName

    describe 'dirty userName input', ->
      beforeEach (done) ->
        NewUserCtrl.regForm = {
          userName:
            $dirty: true
        }
        NewUserCtrl.updateLogin()
        done()

      it 'should not change authServ.userName', () ->
        expect(mockedAuthServ.userName).toBe initName

