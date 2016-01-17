'use strict';

let SteganoClass = require('./stegano.class')
let AuthClass = require('../user/auth.class')
let AuthHelpers = new AuthClass;

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
      let publicText = 'Some public text';
      let hiddenText = 'Some hidden text';

      it('begin', () => {
        this.begin();
      });

      it('should show switch', () => {
        expect(this.switch.isPresent()).toBeTruthy();
      });

      it('should add special post', () => {
        this.addSpecialPost(publicText, hiddenText);
        expect(this.posts.last().element(By.css('img')).isPresent()).toBeTruthy();
        expect(this.posts.last().getText()).toContain(publicText);
        expect(this.posts.last().getText()).not.toContain(hiddenText);
      });

      it('should show hidden content after click on switch', () => {
        this.switch.click();
        expect(this.posts.last().getText()).toContain(hiddenText);
      });

      it('should not show hidden content after second click on switch', () => {
        this.switch.click();
        expect(this.posts.last().getText()).not.toContain(hiddenText);
      });

      it('should logout', () => {
        AuthHelpers.logout();
      });
    });
  }
}

module.exports = new SteganoScenario;
