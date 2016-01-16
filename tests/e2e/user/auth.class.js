'use strict';

let MainClass = require('../lib/main.class');

class AuthClass extends MainClass {
  constructor() {
    super()
  }

  adminUsersMenuClick() {
    element(By.css('[ui-sref="admin.users"]')).click();
  }

  adminRolesMenuClick() {
    element(By.css('[ui-sref="admin.roles"]')).click();
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

  get roles() {
    return element.all(By.repeater('role in rolesA.roles'));
  }

  get defalutRole() {
    return element.all(By.css('md-select span')).first().getText();
  }

  get saveDefaultButton() {
    return element(By.css('[ng-click="rolesA.saveDefaultRole()"]'));
  }

  get saveRolesButton() {
    return element(By.css('[ng-click="rolesA.saveRoles()"]'));
  }

  get addNewRoleButton() {
    return element(By.css('[ng-click="rolesA.addNewRole()"]'));
  }

  changeDefaultRole(which) {
    element(By.css('[ng-model="rolesA.defaultRole"]')).click();
    browser.sleep(500);
    element(By.css('md-select-menu')).all(By.repeater('role in rolesA.roles')).get(which).click();
    browser.sleep(500);
    this.saveDefaultButton.click();
  }

  removeRole(which) {
    this.roles.get(which).element(By.css('[ng-click="rolesA.removeRole(role)"]')).click();
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
    browser.sleep(500);

    this.typeEmail(email);

    this.typeUserName(login);

    this.typePassword(password);

    let registerButton = element(By.css('[ng-click="userCtrl.auth.register()"]'));
    registerButton.click();

    browser.sleep(300);
  }
}

module.exports = AuthClass;
