'use strict';

class MainClass {
  inputOn(inputElement, text) {
    return inputElement.clear().then(() => {
      inputElement.sendKeys(text);
    });
  }
}

module.exports = MainClass;
