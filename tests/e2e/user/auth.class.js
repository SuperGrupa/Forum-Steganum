'use strict';

let MainClass = require('../lib/main.class');

class AuthClass extends MainClass {
  constructor() {
    super()
  }

  get userName() {
    return element(By.css)
  }

  typeEmail(email) {
    let emailInput = element(By.css('[ng-model="userCtrl.auth.email"]'));
    this.inputOn(emailInput, email);
  }

  typePassword(password) {
    let passwordInput = element(By.css('[ng-model="userCtrl.auth.password"]'));
    this.inputOn(passwordInput, password);
  }

  typeUserName(name) {
    let userNameInput = element(By.css('[ng-model="userCtrl.auth.userName"]'));
    this.inputOn(userNameInput, name);
  }

  loginAs(login, password) {
    browser.get('/users/login');

    this.typeEmail(login);

    this.typePassword(password);

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

  registerAs(email, login, password) {
    browser.get('/users/register');

    this.typeEmail(email);

    this.typeUserName(login);

    this.typePassword(password);

    let registerButton = element(By.css('[ng-click="userCtrl.auth.register()"]'));
    registerButton.click();

    browser.sleep(300);
  }
}

module.exports = AuthClass;
