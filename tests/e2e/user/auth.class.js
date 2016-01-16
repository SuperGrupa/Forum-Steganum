'use strict';

let MainClass = require('../lib/main.class');

class AuthClass extends MainClass {
  constructor() {
    super()
  }

  adminUsersMenuClick() {
    element(By.css('[ui-sref="admin.users"]')).click();
  }

  get users() {
    return element.all(By.repeater('user in usersA.users'));
  }

  get lastUserRole() {
    return this.users.last().all(By.css('md-select span')).first().getText();
  }

  get saveUsersButton() {
    return element(By.css('[ng-click="usersA.saveUsers()"]'));
  }

  changeLastUserRole(which) {
    this.users.last().element(By.css('[ng-model="user.role"]')).click();
    browser.sleep(500)
    element(By.css(`[value="${which}"]`)).click();
  }

  removeLastUser() {
    this.users.last().element(By.css('[ng-click="usersA.removeUser(user)"]')).click();
    browser.sleep(500);
    browser.switchTo().alert().accept();
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
