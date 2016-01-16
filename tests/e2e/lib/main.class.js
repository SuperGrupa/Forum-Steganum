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

  inputOn(inputElement, text) {
    return inputElement.clear().then(() => {
      inputElement.sendKeys(text);
    });
  }
}

module.exports = MainClass;
