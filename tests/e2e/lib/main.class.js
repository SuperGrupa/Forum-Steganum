'use strict';

class MainClass {
  get sections() {
    return element.all(By.repeater('section in listDir.sections'));
  }

  get topics() {
    return element.all(By.repeater('topic in showSectionCtrl.topics'));
  }

  get posts() {
    return element.all(By.repeater('post in listDir.posts'));
  }

  get login() {
    element(By.css('[ui-sref="profile"]')).click();
    return element(By.css('[ng-model="currentUser.username"]')).getAttribute('value');
  }

  get email() {
    element(By.css('[ui-sref="profile"]')).click();
    return element(By.css('[ng-model="currentUser.emails[0].address"]')).getAttribute('value');
  }


  inputOn(inputElement, text) {
    return inputElement.clear().then(() => {
      inputElement.sendKeys(text);
    });
  }
}

module.exports = MainClass;
