'use strict';

class SectionClass {
  addSection(name, description) {
    element(By.css('[ui-sref="section.new"]')).click();

    let nameInput = element(By.css('[ng-model="new.section.name"]'));
    nameInput.clear().then(() => {
      nameInput.sendKeys(name);
    });

    let descriptionInput = element(By.css('[ng-model="new.section.description"]'));
    descriptionInput.clear().then(() => {
      descriptionInput.sendKeys(description);
    });

    element(By.css('[type="submit"]')).click();
  }

  editSection(which, name, description) {
    element.all(By.css('.edit')).get(which).click();

    let nameInput = element(By.css('[ng-model="edit.section.name"]'));
    nameInput.clear().then(() => {
      nameInput.sendKeys(name);
    });

    let descriptionInput = element(By.css('[ng-model="edit.section.description"]'));
    descriptionInput.clear().then(() => {
      descriptionInput.sendKeys(description);
    });

    element(By.css('[type="submit"]')).click();
  }
}

module.exports = SectionClass;
