describe 'RolesA controller', ->
  rolesACtrl = {}
  element = {}
  mockedRolesAServ = new TestServ()
  mockedQ = new TestServ()
  mockedAlertsServ = new TestServ()
  roles = [
    {
      name: 'admin'
      _id: 1
      default: false
    }
    {
      name: 'moderator'
      _id: 2
      default: false
    }
    {
      name: 'user'
      _id: 3
      default: true
    }
  ]
  emptyRole = {
    name: ''
    default: false
  }

  beforeEach module('admin')

  compileController = (argRoles) =>
    mockedRolesAServ.addPromise('emptyRole')
    mockedRolesAServ.addMethod('getAllRoles', angular.copy(argRoles))
    mockedRolesAServ.addMethod('removeRole')
    mockedRolesAServ.addPromise('updateRole')
    mockedRolesAServ.addPromise('createRole')
    mockedQ.addPromise('all')
    mockedAlertsServ.addMethod('success')
    mockedAlertsServ.addMethod('warning')
    element = new TestElement()
    rolesACtrl = element.createCtrl('rolesACtrl',
      $q: mockedQ
      alertsServ: mockedAlertsServ
      rolesAServ: mockedRolesAServ
    )
    element.scope.$digest()

  describe 'without default role', ->
    beforeEach ->
      newRoles = angular.copy(roles)
      newRoles[2].default = false
      compileController(newRoles)

    it 'should initialize', ->
      expect(rolesACtrl).toBeDefined()

  describe 'normal', ->
    beforeEach ->
      compileController(roles)

    it 'should initialize', ->
      expect(rolesACtrl).toBeDefined()

    describe 'binding', ->
      it 'should call emptyRole method on rolesAServ', () ->
        expect(mockedRolesAServ.emptyRole).toHaveBeenCalled()

      it 'should bind roles to this', () ->
        expect(rolesACtrl.roles).toEqual roles

      it 'should find default role', () ->
        expect(rolesACtrl.defaultRole).toEqual roles[2]

    describe 'roleModified method', ->
      beforeEach (done) ->
        rolesACtrl.roleModified(rolesACtrl.roles[0])
        done()

      it 'should add updated and selected properties to user with true as a value', () ->
        expect(rolesACtrl.roles[0].updated).toBe true
        expect(rolesACtrl.roles[0].selected).toBe true

    describe 'saveRoles method', ->
      describe 'save 3 roles', ->
        beforeEach (done) ->
          rolesACtrl.roles[0].selected = true
          rolesACtrl.roles[1].selected = true
          newRole = angular.copy emptyRole
          newRole.selected = true
          rolesACtrl.roles.push(newRole)
          rolesACtrl.saveRoles()
          mockedRolesAServ.updateRole.success()
          mockedRolesAServ.updateRole.success()
          mockedRolesAServ.createRole.success()
          done()

        it 'should call updateRole on rolesAServ twice with user', () ->
          expect(mockedRolesAServ.updateRole.calls.count()).toBe 2
          expect(mockedRolesAServ.updateRole.calls.allArgs()).toEqual [[rolesACtrl.roles[0]], [rolesACtrl.roles[1]]]

        it 'should call createRole on rolesAServ once with user', () ->
          expect(mockedRolesAServ.createRole.calls.count()).toBe 1
          expect(mockedRolesAServ.createRole.calls.allArgs()).toEqual [[rolesACtrl.roles[3]]]

        it 'should call all method on $q', () ->
          expect(mockedQ.all).toHaveBeenCalled()

        it 'should call success method on alertsServ', () ->
          mockedQ.all.success()
          expect(mockedAlertsServ.success.calls.allArgs()).toEqual [ [ 'Created', 'You\'ve created 1roles.' ], [ 'Updated', 'You\'ve updated 2roles.' ] ]

      describe 'save 0 roles', ->
        beforeEach (done) ->
          rolesACtrl.saveRoles()
          done()

        it 'should not call updateRole on rolesAServ', () ->
          expect(mockedRolesAServ.updateRole).not.toHaveBeenCalled()

        it 'should call createRole on rolesAServ once with user', () ->
          expect(mockedRolesAServ.createRole).not.toHaveBeenCalled()

        it 'should call all method on $q', () ->
          expect(mockedQ.all).toHaveBeenCalled()

        it 'should not call success method on alertsServ', () ->
          mockedQ.all.success()
          expect(mockedAlertsServ.success).not.toHaveBeenCalled()


    describe 'isRoleSelected method', ->
      describe '0 roles selected', ->
        it 'should return false', () ->
          expect(rolesACtrl.isRoleSelected()).toBe false

      describe '1 role selected', ->
        it 'should return true', () ->
          rolesACtrl.roles[0].selected = true
          expect(rolesACtrl.isRoleSelected()).toBe true

    describe 'removeRole method', ->
      describe 'default role', ->
        beforeEach (done) ->
          rolesACtrl.removeRole(rolesACtrl.roles[2])
          done()

        it 'should show warning', () ->
          expect(mockedAlertsServ.warning).toHaveBeenCalledWith('Warning', 'You can\'t remove default role')

      describe 'confirmed', ->
        beforeEach (done) ->
          spyOn(window, 'confirm').and.returnValue(true)
          done()

        describe 'new role', ->
          cachedRole = {}

          beforeEach (done) ->
            cachedRole = angular.copy(rolesACtrl.roles[0])
            rolesACtrl.roles[0]._id = undefined
            rolesACtrl.removeRole(rolesACtrl.roles[0])
            done()

          it 'should remove role from array', () ->
            expect(rolesACtrl.roles[0]).not.toEqual cachedRole


        describe 'not new role', ->
          beforeEach (done) ->
            rolesACtrl.removeRole(rolesACtrl.roles[0])
            done()

          it 'should call removeRole method on usersAServ with user id', () ->
            expect(mockedRolesAServ.removeRole).toHaveBeenCalledWith(rolesACtrl.roles[0])

      describe 'unconfirmed', ->
        beforeEach (done) ->
          spyOn(window, 'confirm').and.returnValue(false)
          rolesACtrl.removeRole(rolesACtrl.roles[0])
          done()

        it 'should not call removeRole method on usersAServ', () ->
          expect(mockedRolesAServ.removeRole).not.toHaveBeenCalled()

    describe 'addNewRole method', ->
      it 'should add new empty role to the beggining of the this.roles array', () ->
        mockedRolesAServ.emptyRole.success(angular.copy(emptyRole))
        rolesACtrl.addNewRole()
        expect(rolesACtrl.roles[0]).toEqual
          name: emptyRole.name
          default: emptyRole.default
          selected: true
          updated: true

    describe 'saveDefaultRole method', ->
      beforeEach (done) ->
        rolesACtrl.defaultRole = rolesACtrl.roles[1]
        rolesACtrl.saveDefaultRole()
        mockedRolesAServ.updateRole.success()
        mockedRolesAServ.updateRole.success()
        done()

      it 'should call updateRole method on rolesAServ with new default role', () ->
        expect(rolesACtrl.roles[1].default).toBe true
        expect(mockedRolesAServ.updateRole).toHaveBeenCalledWith rolesACtrl.roles[1]

      it 'should call updateRole method on rolesAServ with old default role', () ->
        expect(rolesACtrl.roles[2].default).toBe false
        expect(mockedRolesAServ.updateRole).toHaveBeenCalledWith rolesACtrl.roles[2]

      it 'should show success message', () ->
        expect(mockedAlertsServ.success).toHaveBeenCalledWith('Updated', 'moderator is now default role.' )





