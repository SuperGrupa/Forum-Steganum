'use strict';

class AuthHelpers {
  loginAs(login, password) {
    browser.get('/users/login');

    let loginInput = element(By.css('[ng-model="userCtrl.auth.email"]'));
    loginInput.clear().then(() => {
      loginInput.sendKeys(login);
    });

    let passwordInput = element(By.css('[ng-model="userCtrl.auth.password"]'));
    passwordInput.clear().then(() => {
      passwordInput.sendKeys(password);
    });

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
