'use strict';
let SectionClass = require('./section.class')
let AuthHelpers = require('../user/auth.helpers')

class SectionsScenario extends SectionClass {
  constructor() {
    super();
    this.begin();
  }

  begin() {
      browser.get('/#/portfolio');
  }

  run() {
    describe('Sections scenario', () => {
      let newSection = {
        name: 'someSectionName',
        description: 'someSectionDescription'
      };
      let editSection = {
        name: 'updatedName',
        description: 'updatedSectionDescription'
      };


      it('should login', () => {
        AuthHelpers.loginAs('admin', 'admin');
      });

      describe('Sections page', () => {
        let sectionsCountBefore;

        beforeEach(() => {
          browser.get('/sections');
          browser.sleep(500);

          element.all(By.repeater('section in listDir.sections')).count().then(function(count) {
            sectionsCountBefore = count;
          });
        });

        it('should add a new section', () => {
          this.addSection(newSection.name, newSection.description);
          this.addSection(newSection.name, newSection.description);

          let sections = element.all(By.repeater('section in listDir.sections'));

          expect(sections.count()).toBe(sectionsCountBefore + 2);
          expect(sections.last().getText()).toContain(newSection.name);
          expect(sections.last().getText()).toContain(newSection.description);
        });

        it('should edit the first section', () => {
          this.editSection(0, editSection.name, editSection.description);

          let sections = element.all(By.repeater('section in listDir.sections'));

          expect(sections.first().getText()).toContain(editSection.name);
          expect(sections.first().getText()).toContain(editSection.description);
        });

        it('should delete the last section', () => {
          element.all(By.css('.delete')).last().click();
          element.all(By.css('[ng-click="delSecCtrl.state.goBack()"]')).last().click();

          element.all(By.css('.delete')).last().click();
          element.all(By.css('[ng-click="sectionCtrl.section.delete(delSecCtrl.section.id)"]')).last().click();

          let sections = element.all(By.repeater('section in listDir.sections'));

          expect(sections.count()).toBe(sectionsCountBefore - 1);
          expect(sections.first().getText()).toContain(editSection.name);
          expect(sections.first().getText()).toContain(editSection.description);
        });
      });

      it('should logout', () => {
        AuthHelpers.logout();
      });
    });
  }
}

module.exports = new SectionsScenario;
