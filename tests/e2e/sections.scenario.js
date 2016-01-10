'use strict';
var helpers = require('./helpers');

describe('Sections scenario', function() {
  var section = {
    name: 'someName',
    description: 'someDescription'
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

    it('should add new section', function() {

      element(By.css('[ui-sref="section.new"]')).click();

      var nameInput = element(By.css('[ng-model="new.section.name"]'));
      nameInput.clear().then(function() {
        nameInput.sendKeys(section.name);
      });

      var descriptionInput = element(By.css('[ng-model="new.section.description"]'));
      descriptionInput.clear().then(function() {
        descriptionInput.sendKeys(section.description);
      });

      element(By.css('[type="submit"]')).click();
      var sections = element.all(By.repeater('section in listDir.sections'));

      expect(sections.count()).toBe(sectionsCountBefore + 1);
      expect(sections.last().getText()).toContain(section.name);
      expect(sections.last().getText()).toContain(section.description);
    });
  });

  it('should logout', function() {
    helpers.logout();
  });
});
