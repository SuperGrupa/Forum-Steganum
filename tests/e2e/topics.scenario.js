'use strict';
var helpers = require('./helpers');

module.exports = {
  run: function() {
    describe('Topics scenario', function() {
      var newTopic = {
        name: 'someTopicName',
        description: 'someTopicDescription'
      };
      var editTopic = {
        name: 'updatedTopicName',
        description: 'updatedTopicDescription'
      };


      it('should login', function() {
        helpers.loginAs('admin', 'admin');
      });

      describe('Topics page', function() {
        var topicsCountBefore;

        beforeEach(function() {
          browser.get('/sections');
          browser.sleep(500);
          element.all(By.repeater('section in listDir.sections')).first().click();

          element.all(By.repeater('topic in showSectionCtrl.topics')).count().then(function(count) {
            topicsCountBefore = count;
          });
        });

        it('should add a new topic', function() {
          helpers.addTopic(newTopic.name, newTopic.description);
          helpers.addTopic(newTopic.name, newTopic.description);

          var topics = element.all(By.repeater('topic in showSectionCtrl.topics'));

          expect(topics.count()).toBe(topicsCountBefore + 2);
          expect(topics.first().getText()).toContain(newTopic.name);
          expect(topics.first().getText()).toContain(newTopic.description);
        });

        it('should edit the first topic', function() {
          helpers.editTopic(0, editTopic.name, editTopic.description);

          var topics = element.all(By.repeater('topic in showSectionCtrl.topics'));

          expect(topics.first().getText()).toContain(editTopic.name);
          expect(topics.first().getText()).toContain(editTopic.description);
        });

        it('should delete the last topic', function() {
          element.all(By.css('.delete')).last().click();
          element.all(By.css('[ng-click="deleteTopicCtrl.state.goBack()"]')).last().click();

          element.all(By.css('.delete')).last().click();
          element.all(By.css('[ng-click="topicsCtrl.topic.delete(deleteTopicCtrl.topic.id)"]')).last().click();

          var topics = element.all(By.repeater('topic in showSectionCtrl.topics'));

          expect(topics.count()).toBe(topicsCountBefore - 1);
          expect(topics.first().getText()).toContain(editTopic.name);
          expect(topics.first().getText()).toContain(editTopic.description);
        });
      });

      it('should logout', function() {
        helpers.logout();
      });
    });
  }
}
