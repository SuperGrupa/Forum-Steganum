'use strict';

let AuthClass = require('./auth.class')

class AdminScenario extends AuthClass {
  constructor() {
    super();
  }

  begin() {
    this.loginAs('admin', 'admin');
    browser.sleep(500);
    element(By.css('[ui-sref="admin.main"]')).click();
  }

  run() {
    describe('Admin Panel scenario', () => {
      it('begin', () => {
        this.begin();
      });

      describe('users', () => {
        it('got to users', () => {
          this.adminUsersMenuClick();
        });

        let usersCountBefore;

        beforeEach(() => {
          this.users.count().then((count) => {
            usersCountBefore = count;
          });
        });

        it('should show user, banned and moderator users', () => {
          expect(this.users.get(2).getText()).toContain('user');
          expect(this.users.get(0).getText()).toContain('moderator');
          expect(this.users.get(1).getText()).toContain('banned');
        });

        it('should not contain admin user', () => {
          expect(this.users.getText()).not.toContain('admin');
        });

        it('last user should have user role set', () => {
          expect(this.lastUserRole).toEqual('user');
        });

        it('save users button should be disabled', () => {
          expect(this.saveUsersButton.getAttribute('disabled')).toBeTruthy();
        });

        it('change last user role', () => {
          this.changeLastUserRole('moderator');
          expect(this.lastUserRole).toEqual('moderator');
        });

        it('should enable save users button', () => {
          expect(this.saveUsersButton.getAttribute('disabled')).toBeFalsy();
        });

        it('should save users after click button', () => {
          this.saveUsersButton.click();
          browser.get('/admin/users');
          expect(this.lastUserRole).toEqual('moderator');
        });

        it('remove last user', () => {
          this.removeLastUser();
          expect(this.users.count()).toBe(usersCountBefore - 1);
        });
      });

      describe('roles', () => {
        it('got to roles', () => {
          this.adminRolesMenuClick();
        });

        let rolesCountBefore;

        beforeEach(() => {
          this.roles.count().then((count) => {
            rolesCountBefore = count;
          });
        });

        it('should not contain admin user', () => {
          expect(this.roles.getText()).not.toContain('admin');
        });

        it('default role should be user', () => {
          expect(this.defalutRole).toEqual('user');
        });

        it('save default role button should be disabled', () => {
          expect(this.saveDefaultButton.getAttribute('disabled')).toBeTruthy();
        });

        it('change default role', () => {
          this.changeDefaultRole(1);
          expect(this.defalutRole).toEqual('moderator');
        });

        describe('new user', () => {
          let username = 'random' + Math.floor(Math.random() * 10000);
          let email = username + '@fs.com';
          let password = 'supersecret';

          it('should have moderator role', () => {
            this.logout();
            this.registerAs(email, username, password);
            this.logout();
            this.begin();
            this.adminUsersMenuClick();
            expect(this.lastUserRole).toEqual('moderator');
          });

          it('go back to roles and change default role', () => {
            this.removeLastUser();
            this.adminRolesMenuClick();
            this.changeDefaultRole(2);
            expect(this.defalutRole).toEqual('user');
          });
        });

        it('save roles button should be disabled', () => {
          expect(this.saveRolesButton.getAttribute('disabled')).toBeTruthy();
        });

        it('add new role', () => {
          this.addNewRoleButton.click();
          expect(this.roles.count()).toBe(rolesCountBefore + 1)
        });

        it('save roles button should not be disabled', () => {
          expect(this.saveRolesButton.getAttribute('disabled')).toBeFalsy();
        });

        it('save role', () => {
          this.saveRolesButton.click();
          browser.get('/admin/roles');
          expect(this.roles.count()).toBe(4);
        });

        it('delete role', () => {
          this.removeRole(2);
          expect(this.roles.count()).toBe(3);
        });
      });

      it('logout', () => {
        this.logout();
      });
    });
  }
}

module.exports = new AdminScenario;
