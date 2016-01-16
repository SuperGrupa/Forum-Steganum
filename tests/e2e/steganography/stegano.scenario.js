'use strict';

let SteganoClass = require('./stegano.class')
let AuthHelpers = require('../user/auth.helpers')

class SteganoScenario extends SteganoClass {
  constructor() {
    super();
  }

  begin() {
    AuthHelpers.loginAs('user', 'user');
    browser.get('/');
    browser.sleep(500);
    this.firstStep();
    this.secondStep();
    this.thirdStep();
  }

  run() {
    describe('Stegano scenario', () => {
      it('begin', () => {
        this.begin();
      });

      it('should show switch', () => {
        expect(this.switch.isPresent()).toBeTruthy();
      });

      it('should logout', () => {
        AuthHelpers.logout();
      });
    });
  }
}

module.exports = new SteganoScenario;
