'use strict';

let MainClass = require('../lib/main.class');

class TopicClass extends MainClass {
  constructor() {
    super()
  }

  addTopic(name, description) {
    element(By.css('.submit')).click();

    var nameInput = element(By.css('[ng-model="new.topic.name"]'));
    this.inputOn(nameInput, name);

    var descriptionInput = element(By.css('[ng-model="new.topic.description"]'));
    this.inputOn(descriptionInput, description);

    element(By.css('[type="submit"]')).click();
  }

  editTopic(which, name, description) {
    element.all(By.css('.edit')).get(which).click();

    var nameInput = element(By.css('[ng-model="edit.topic.name"]'));
    this.inputOn(nameInput, name);

    var descriptionInput = element(By.css('[ng-model="edit.topic.description"]'));
    this.inputOn(descriptionInput, description);

    element(By.css('[type="submit"]')).click();
  }


  deleteLast() {
    return element.all(By.css('.delete')).last().click();
  }

  cancelDelete() {
    return element.all(By.css('[ng-click="deleteTopicCtrl.state.goBack()"]')).last().click();
  }

  confirmDelete() {
    return element.all(By.css('[ng-click="topicsCtrl.topic.delete(deleteTopicCtrl.topic.id)"]')).last().click();
  }
}

module.exports = TopicClass;
