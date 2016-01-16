'use strict';

let MainClass = require('../lib/main.class');

class ProfileClass extends MainClass {
  constructor() {
    super();
  }

  updateCatYears(text) {
    element(By.css('[ui-sref="profile"]')).click();

    let input = element(By.css('[ng-model="currentUser.profile.catyears"]'));
    this.inputOn(input, text);

    element(By.css('.prof-button')).click();
  }
}

module.exports = ProfileClass;
