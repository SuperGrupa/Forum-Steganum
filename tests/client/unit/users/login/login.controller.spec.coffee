# describe 'Login controller', ->
#   $scope = {}
#   $controller = {}
#   LoginCtrl = {}
#   previousState = {
#     name: 'dsa'
#   }
#   mockedMeteor = {
#     loginWithPassword: angular.noop
#   }
#   mockedState = {
#     go: angular.noop,
#     previous: previousState
#   }
#   cred = {
#     email: 'super@email.com'
#     password: 'secret'
#   }
#   successCallBack = null
#   failCallBack = null

#   beforeEach module('forumSteganum')

#   beforeEach inject(($injector) ->
#     $controller = $injector.get('$controller')
#     $scope = $injector.get('$rootScope').$new()
#     LoginCtrl = $controller('LoginCtrl as logCtrl',
#       $scope: $scope
#       $meteor: mockedMeteor
#       $state: mockedState
#     )
#   )
#   beforeEach (done) ->
#     spyOn(mockedMeteor, 'loginWithPassword').and.returnValue
#       then: (success, fail) ->
#         successCallBack = success;
#         failCallBack = fail;
#     spyOn(mockedState, 'go')

#     LoginCtrl.credentials = cred
#     done()

#   it 'should initialize', ->
#     expect(LoginCtrl).toBeDefined()

#   describe 'success login', ->
#     describe 'is previous state', ->
#       beforeEach (done) ->
#         mockedState.previous.name = 'previous state'
#         LoginCtrl.login()
#         successCallBack()
#         done()

#       it 'should call loginWithPassword method on meteor', () ->
#         expect(mockedMeteor.loginWithPassword).toHaveBeenCalledWith cred.email, cred.password

#       it 'should call go method on state', () ->
#         expect(mockedState.go).toHaveBeenCalledWith mockedState.previous

#     describe 'is not previous state', ->
#       beforeEach (done) ->
#         mockedState.previous.name = ''
#         LoginCtrl.login()
#         successCallBack()
#         done()

#       it 'should call loginWithPassword method on meteor', () ->
#         expect(mockedMeteor.loginWithPassword).toHaveBeenCalledWith cred.email, cred.password

#       it 'should call go method on state', () ->
#         expect(mockedState.go).toHaveBeenCalledWith 'home'

#   describe 'failed login', ->
#     error = 'some error'
#     beforeEach (done) ->
#       mockedState.previous.name = ''
#       LoginCtrl.login()
#       failCallBack(error)
#       done()

#     it 'should call loginWithPassword method on meteor', () ->
#       expect(mockedMeteor.loginWithPassword).toHaveBeenCalledWith cred.email, cred.password

#     it 'should not call go method on state', () ->
#       expect(mockedState.go).not.toHaveBeenCalledWith 'home'

#     it 'should not call go method on state', () ->
#       expect(LoginCtrl.error).toContain error

