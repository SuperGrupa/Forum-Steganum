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

    browser.sleep(300);
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
  },

  addTopic: function(name, description) {
    element(By.css('.submit')).click();

    var nameInput = element(By.css('[ng-model="new.topic.name"]'));
    nameInput.clear().then(function() {
      nameInput.sendKeys(name);
    });

    var descriptionInput = element(By.css('[ng-model="new.topic.description"]'));
    descriptionInput.clear().then(function() {
      descriptionInput.sendKeys(description);
    });

    element(By.css('[type="submit"]')).click();
  },

  editTopic: function(which, name, description) {
    element.all(By.css('.edit')).get(which).click();

    var nameInput = element(By.css('[ng-model="edit.topic.name"]'));
    nameInput.clear().then(function() {
      nameInput.sendKeys(name);
    });

    var descriptionInput = element(By.css('[ng-model="edit.topic.description"]'));
    descriptionInput.clear().then(function() {
      descriptionInput.sendKeys(description);
    });

    element(By.css('[type="submit"]')).click();
  },

  addPost: function(text) {
    var textInput = element(By.css('[ng-model="new.post.text"]'));
    textInput.clear().then(function() {
      textInput.sendKeys(text);
    });

    element(By.css('[type="submit"]')).click();
  },

  editPost: function(which, text) {
    element.all(By.css('.edit')).get(which).click();

    var textInput = element.all(By.css('[ng-model="live.object.text"]')).first();
    textInput.clear().then(function() {
      textInput.sendKeys(text);
    });

    element.all(By.css('[ng-click="live.save()"]')).first().click();
  }
}
