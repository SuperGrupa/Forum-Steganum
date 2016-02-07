'use strict';

let AuthClass = require('./auth.class')

class UsersScenario extends AuthClass {
  constructor() {
    super();
  }

  begin() {
  }

  run() {
    describe('Authentication scenario', () => {
      let username = 'random' + Math.floor(Math.random() * 10000);
      let email = username + '@fs.com';
      let password = 'supersecret';

      it('should create account', () => {
        this.registerAs(email, username, password);
        expect(this.login).toEqual(username);
        expect(this.email).toEqual(email);
      });

      it('logout', () => {
        this.logout();
      });

      it('should login with the same email', () => {
        this.loginAs(email, password);
        expect(this.login).toEqual(username);
        expect(this.email).toEqual(email);
      });

      it('logout', () => {
        this.logout();
      });

      it('should login with the same username', () => {
        this.loginAs(username, password);
        expect(this.login).toEqual(username);
        expect(this.email).toEqual(email);
      });

      it('logout', () => {
        this.logout();
      });
    });
  }
}

module.exports = new UsersScenario;
