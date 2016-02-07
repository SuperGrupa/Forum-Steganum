'use strict';

let MainClass = require('../lib/main.class');

class SectionClass extends MainClass {
  constructor() {
    super()
  }

  addSection(name, description) {
    element(By.css('[ui-sref="section.new"]')).click();

    let nameInput = element(By.css('[ng-model="new.section.name"]'));
    this.inputOn(nameInput, name);

    let descriptionInput = element(By.css('[ng-model="new.section.description"]'));
    this.inputOn(descriptionInput, description);

    element(By.css('[type="submit"]')).click();
  }

  editSection(which, name, description) {
    element.all(By.css('.edit')).get(which).click();

    let nameInput = element(By.css('[ng-model="edit.section.name"]'));
    this.inputOn(nameInput, name);

    let descriptionInput = element(By.css('[ng-model="edit.section.description"]'));
    this.inputOn(descriptionInput, description);

    element(By.css('[type="submit"]')).click();
  }

  deleteLast() {
    return element.all(By.css('.delete')).last().click();
  }

  cancelDelete() {
    return element.all(By.css('[ng-click="delSecCtrl.state.goBack()"]')).last().click();
  }

  confirmDelete() {
    return element.all(By.css('[ng-click="sectionCtrl.section.delete(delSecCtrl.section.id)"]')).last().click();
  }
}

module.exports = SectionClass;
