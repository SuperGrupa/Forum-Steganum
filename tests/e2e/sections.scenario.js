'use strict';
var helpers = require('./helpers');

module.exports = {
  run: function() {
    describe('Sections scenario', function() {
      var newSection = {
        name: 'someSectionName',
        description: 'someSectionDescription'
      };
      var editSection = {
        name: 'updatedName',
        description: 'updatedSectionDescription'
      };


      it('should login', function() {
        helpers.loginAs('admin', 'admin');
      });

      describe('Sections page', function() {
        var sectionsCountBefore;

        beforeEach(function() {
          browser.get('/sections');
          browser.sleep(500);

          element.all(By.repeater('section in listDir.sections')).count().then(function(count) {
            sectionsCountBefore = count;
          });
        });

        it('should add a new section', function() {
          helpers.addSection(newSection.name, newSection.description);
          helpers.addSection(newSection.name, newSection.description);

          var sections = element.all(By.repeater('section in listDir.sections'));

          expect(sections.count()).toBe(sectionsCountBefore + 2);
          expect(sections.last().getText()).toContain(newSection.name);
          expect(sections.last().getText()).toContain(newSection.description);
        });

        it('should edit the first section', function() {
          helpers.editSection(0, editSection.name, editSection.description);

          var sections = element.all(By.repeater('section in listDir.sections'));

          expect(sections.first().getText()).toContain(editSection.name);
          expect(sections.first().getText()).toContain(editSection.description);
        });

        it('should delete the last section', function() {
          element.all(By.css('.delete')).last().click();
          element.all(By.css('[ng-click="delSecCtrl.state.goBack()"]')).last().click();

          element.all(By.css('.delete')).last().click();
          element.all(By.css('[ng-click="sectionCtrl.section.delete(delSecCtrl.section.id)"]')).last().click();

          var sections = element.all(By.repeater('section in listDir.sections'));

          expect(sections.count()).toBe(sectionsCountBefore - 1);
          expect(sections.first().getText()).toContain(editSection.name);
          expect(sections.first().getText()).toContain(editSection.description);
        });
      });

      it('should logout', function() {
        helpers.logout();
      });
    });
  }
}
