describe 'UsersA controller', ->
  usersACtrl = {}
  mockedUsersAServ = new TestServ()
  mockedRolesAServ = new TestServ()
  mockedQ = new TestServ()
  mockedAlertsServ = new TestServ()
  users = [
    {
      name: 'Nedd'
      _id: 1
    }
    {
      name: 'Tyrion'
      _id: 2
    }
    {
      name: 'Jon'
      _id: 3
    }
  ]
  roles = [
    { name: 'admin' }
    { name: 'user' }
  ]

  beforeEach (done) ->
    mockedUsersAServ.addMethod('getAllUsers', angular.copy(users))
    mockedUsersAServ.addMethod('removeUser')
    mockedUsersAServ.addPromise('updateUser')
    mockedRolesAServ.addMethod('getAllRoles', angular.copy(roles))
    mockedQ.addPromise('all')
    mockedAlertsServ.addMethod('success')
    done()

  beforeEach module('admin')

  beforeEach ->
    usersACtrl = new TestElement().createCtrl('usersACtrl',
      $q: mockedQ
      alertsServ: mockedAlertsServ
      usersAServ: mockedUsersAServ
      rolesAServ: mockedRolesAServ
    )


  it 'should initialize', ->
    expect(usersACtrl).toBeDefined()

  describe 'binding', ->
    it 'should bind users to this', () ->
      expect(usersACtrl.users).toEqual users

    it 'should bind roles to this', () ->
      expect(usersACtrl.roles).toEqual roles

  describe 'userModified method', ->
    beforeEach (done) ->
      usersACtrl.userModified(usersACtrl.users[0])
      done()

    it 'should add updated and selected properties to user with true as a value', () ->
      expect(usersACtrl.users[0].updated).toBe true
      expect(usersACtrl.users[0].selected).toBe true

  describe 'saveUsers method', ->
    beforeEach (done) ->
      usersACtrl.users[0].selected = true
      usersACtrl.users[1].selected = true
      usersACtrl.saveUsers()
      mockedUsersAServ.updateUser.success()
      mockedUsersAServ.updateUser.success()
      done()

    it 'should call updateUser on usersAServ twice with user', () ->
      expect(mockedUsersAServ.updateUser.calls.count()).toBe 2
      expect(mockedUsersAServ.updateUser.calls.allArgs()).toEqual [[usersACtrl.users[0]], [usersACtrl.users[1]]]

    it 'should call all method on $q', () ->
      expect(mockedQ.all).toHaveBeenCalled()

    it 'should call success method on alertsServ', () ->
      mockedQ.all.success()
      expect(mockedAlertsServ.success).toHaveBeenCalledWith('Updated', 'You\'ve updated 2 users.' )

  describe 'isUserSelected method', ->
    describe '0 users selected', ->
      it 'should return false', () ->
        expect(usersACtrl.isUserSelected()).toBe false

    describe '1 user selected', ->
      it 'should return true', () ->
        usersACtrl.users[0].selected = true
        expect(usersACtrl.isUserSelected()).toBe true

  describe 'removeUser method', ->
    describe 'confirmed', ->
      beforeEach (done) ->
        spyOn(window, 'confirm').and.returnValue(true)
        usersACtrl.removeUser(usersACtrl.users[0])
        done()

      it 'should call removeUser method on usersAServ with user id', () ->
        expect(mockedUsersAServ.removeUser).toHaveBeenCalledWith(usersACtrl.users[0]._id)

    describe 'unconfirmed', ->
      beforeEach (done) ->
        spyOn(window, 'confirm').and.returnValue(false)
        usersACtrl.removeUser(usersACtrl.users[0])
        done()

      it 'should not call removeUser method on usersAServ', () ->
        expect(mockedUsersAServ.removeUser).not.toHaveBeenCalled()





