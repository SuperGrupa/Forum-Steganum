'use strict';

let MainClass = require('../lib/main.class');
let path = require('path');

class PostClass extends MainClass {
  constructor() {
    super()
  }

  addPost(text) {
    var textInput = element(By.css('[ng-model="new.post.text"]'));
    this.inputOn(textInput, text);

    element(By.css('[type="submit"]')).click();
  }

  editPost(which, text) {
    element.all(By.css('.edit')).get(which).click();

    var textInput = element.all(By.css('[ng-model="live.object.text"]')).first();
    this.inputOn(textInput, text);

    element.all(By.css('[ng-click="live.save()"]')).first().click();
  }

  deleteLast() {
    return element.all(By.css('.delete')).last().click();
  }

  editLastPostWithNothing() {
    element.all(By.css('.edit')).last().click();
    element.all(By.css('[ng-click="live.save()"]')).last().click();
  }

  addImage(name) {
    if (!name) {
      name = 'cat.png';
    }
    // requires an absolute path
    var fileToUpload = `../images/${name}`;
    var absolutePath = path.resolve(__dirname, fileToUpload);

    // Find the file input element
    var fileElem = element(by.css('input[type="file"]'));

    // Need to unhide flowjs's secret file uploader
    browser.executeScript(
      `arguments[0].style.visibility = 'visible';
        arguments[0].style.height = '1px';
        arguments[0].style.width = '1px';
        arguments[0].style.opacity = 1;
        arguments[0].style.display = 'initial'`,
      fileElem.getWebElement());

    // Sending the keystrokes will ultimately submit the request.  No need to simulate the click
    fileElem.sendKeys(absolutePath);

    // Not sure how to wait for the upload and response to return first
    // I need this since I have a test that looks at the results after upload
    //  ...  there is probably a better way to do this, but I punted
    browser.sleep(1000);
  }
}

module.exports = PostClass;
