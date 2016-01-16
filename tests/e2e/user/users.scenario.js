'use strict';

let AuthClass = require('./auth.class')

class SteganoScenario extends AuthClass {
  constructor() {
    super();
  }

  begin() {
    browser.get('/');
    browser.sleep(500);
  }

  run() {
    describe('Authentication scenario', () => {
      let username = 'random' + Math.floor(Math.random() * 10000);
      let email = username + '@fs.com';
      let password = 'supersecret';

      it('begin', () => {
        this.begin();
      });

      it('should create account', () => {
        this.registerAs(email, username, password);
        expect(this.login).toEqual(username);
        expect(this.email).toEqual(email);
      });

    });
  }
}

module.exports = new SteganoScenario;
