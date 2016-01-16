'use strict';
let TopicClass = require('./topic.class')
let AuthClass = require('../user/auth.class')
let AuthHelpers = new AuthClass;

class TopicsScenario extends TopicClass {
  constructor() {
    super();
  }

  begin() {
    AuthHelpers.loginAs('admin', 'admin');
    browser.get('/sections');
    browser.sleep(500);
    this.sections.first().click();
  }

  run() {
    describe('Topics scenario', () => {
      let newTopic = {
        name: 'someTopicName',
        description: 'someTopicDescription'
      };
      let editTopic = {
        name: 'updatedTopicName',
        description: 'updatedTopicDescription'
      };

      it('begin', () => {
        this.begin();
      });

      describe('Topics page', () => {
        let topicsCountBefore;

        beforeEach(() => {
          this.topics.count().then((count) => {
            topicsCountBefore = count;
          });
        });

        it('should add a new topic', () => {
          this.addTopic(newTopic.name, newTopic.description);
          this.addTopic(newTopic.name, newTopic.description);

          expect(this.topics.count()).toBe(topicsCountBefore + 2);
          expect(this.topics.first().getText()).toContain(newTopic.name);
          expect(this.topics.first().getText()).toContain(newTopic.description);
        });

        it('should edit the first topic', () => {
          this.editTopic(0, editTopic.name, editTopic.description);

          expect(this.topics.first().getText()).toContain(editTopic.name);
          expect(this.topics.first().getText()).toContain(editTopic.description);
        });

        it('should delete the last topic', () => {
          this.deleteLast();
          this.cancelDelete();

          this.deleteLast();
          this.confirmDelete();

          expect(this.topics.count()).toBe(topicsCountBefore - 1);
          expect(this.topics.first().getText()).toContain(editTopic.name);
          expect(this.topics.first().getText()).toContain(editTopic.description);
        });
      });

      it('should logout', () => {
        AuthHelpers.logout();
      });
    });
  }
}

module.exports = new TopicsScenario;
