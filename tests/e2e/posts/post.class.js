'use strict';

let MainClass = require('../lib/main.class');

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
}

module.exports = PostClass;
