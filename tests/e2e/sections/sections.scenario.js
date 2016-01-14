'use strict';
let SectionClass = require('./section.class')
let AuthHelpers = require('../user/auth.helpers')

class SectionsScenario extends SectionClass {
  constructor() {
    super();
    this.begin();
  }

  begin() {
    AuthHelpers.loginAs('admin', 'admin');
    browser.get('/sections');
    browser.sleep(500);
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

      describe('Sections page', () => {
        let sectionsCountBefore;

        beforeEach(() => {
          this.sections.count().then(function(count) {
            sectionsCountBefore = count;
          });
        });

        it('should add a new section', () => {
          this.addSection(newSection.name, newSection.description);
          this.addSection(newSection.name, newSection.description);

          expect(this.sections.count()).toBe(sectionsCountBefore + 2);
          expect(this.sections.last().getText()).toContain(newSection.name);
          expect(this.sections.last().getText()).toContain(newSection.description);
        });

        it('should edit the first section', () => {
          this.editSection(0, editSection.name, editSection.description);

          expect(this.sections.first().getText()).toContain(editSection.name);
          expect(this.sections.first().getText()).toContain(editSection.description);
        });

        it('should delete the last section', () => {
          this.deleteLast();
          this.cancelDelete();

          this.deleteLast();
          this.confirmDelete();

          expect(this.sections.count()).toBe(sectionsCountBefore - 1);
          expect(this.sections.first().getText()).toContain(editSection.name);
          expect(this.sections.first().getText()).toContain(editSection.description);
        });
      });

      it('should logout', () => {
        AuthHelpers.logout();
      });
    });
  }
}

module.exports = new SectionsScenario;
