'use strict';

let MainClass = require('../lib/main.class');

class AuthHelpers extends MainClass {
  constructor() {
    super()
  }

  loginAs(login, password) {
    browser.get('/users/login');

    let loginInput = element(By.css('[ng-model="userCtrl.auth.email"]'));
    this.inputOn(loginInput, login);

    let passwordInput = element(By.css('[ng-model="userCtrl.auth.password"]'));
    this.inputOn(passwordInput, password);

    let loginButton = element(By.css('[ng-click="userCtrl.auth.logIn()"]'));
    loginButton.click();

    browser.sleep(300);
  }

  logout() {
    let logoutButton = element(By.css('[ng-click="headCtrl.logout()"]'));
    logoutButton.isDisplayed().then(() => {
      logoutButton.click();
    });
  }
}

module.exports = new AuthHelpers;
