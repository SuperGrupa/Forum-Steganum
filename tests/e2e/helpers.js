module.exports = {
  loginAs: function(login, password) {
    browser.get('/users/login');

    var loginInput = element(By.css('[ng-model="userCtrl.auth.email"]'));
    loginInput.clear().then(function() {
      loginInput.sendKeys(login);
    });

    var passwordInput = element(By.css('[ng-model="userCtrl.auth.password"]'));
    passwordInput.clear().then(function() {
      passwordInput.sendKeys(password);
    });

    var loginButton = element(By.css('[ng-click="userCtrl.auth.logIn()"]'));
    loginButton.click();

    browser.sleep(100);
  },

  logout: function() {
    var logoutButton = element(By.css('[ng-click="headCtrl.logout()"]'));
    logoutButton.isDisplayed().then(function() {
      logoutButton.click();
    });
  }
}
