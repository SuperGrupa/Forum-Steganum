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
  },

  addSection: function(name, description) {
    element(By.css('[ui-sref="section.new"]')).click();

    var nameInput = element(By.css('[ng-model="new.section.name"]'));
    nameInput.clear().then(function() {
      nameInput.sendKeys(name);
    });

    var descriptionInput = element(By.css('[ng-model="new.section.description"]'));
    descriptionInput.clear().then(function() {
      descriptionInput.sendKeys(description);
    });

    element(By.css('[type="submit"]')).click();
  },

  editSection: function(which, name, description) {
    element.all(By.css('.edit')).get(which).click();

    var nameInput = element(By.css('[ng-model="edit.section.name"]'));
    nameInput.clear().then(function() {
      nameInput.sendKeys(name);
    });

    var descriptionInput = element(By.css('[ng-model="edit.section.description"]'));
    descriptionInput.clear().then(function() {
      descriptionInput.sendKeys(description);
    });

    element(By.css('[type="submit"]')).click();
  }
}
