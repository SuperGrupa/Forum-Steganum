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
          expect(this.users.count()).toBe(usersCountBefore - 1)
        });
      });
    });
  }
}

module.exports = new AdminScenario;
