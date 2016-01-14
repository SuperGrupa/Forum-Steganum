'use strict';

class MainClass {
  get topics() {
    return element.all(By.repeater('topic in showSectionCtrl.topics'));
  }

  get sections() {
    return element.all(By.repeater('section in listDir.sections'));
  }

  inputOn(inputElement, text) {
    return inputElement.clear().then(() => {
      inputElement.sendKeys(text);
    });
  }
}

module.exports = MainClass;
