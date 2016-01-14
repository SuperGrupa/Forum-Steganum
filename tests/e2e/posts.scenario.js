'use strict';
var helpers = require('./helpers');

module.exports = {
  run: function() {
    describe('Posts scenario', function() {
      var newPost = {
        text: 'somePostName'
      };
      var editPost = {
        text: 'updatedPostName'
      };


      it('should login', function() {
        helpers.loginAs('admin', 'admin');
      });

      describe('Posts page', function() {
        var postsCountBefore;

        beforeEach(function() {
          browser.get('/sections');
          browser.sleep(500);
          element.all(By.repeater('section in listDir.sections')).first().click();
          element.all(By.repeater('topic in showSectionCtrl.topics')).first().click();

          element.all(By.repeater('post in listDir.posts')).count().then(function(count) {
            postsCountBefore = count;
          });
        });

        it('should add a new post', function() {
          helpers.addPost(newPost.text);
          helpers.addPost(newPost.text);

          var posts = element.all(By.repeater('post in listDir.posts'));

          expect(posts.count()).toBe(postsCountBefore + 2);
          expect(posts.last().getText()).toContain(newPost.text);
          expect(posts.last().getText()).toContain('admin');
        });

        it('should edit the first post', function() {
          helpers.editPost(0, editPost.text);

          var posts = element.all(By.repeater('post in listDir.posts'));

          expect(posts.first().getText()).toContain(editPost.text);
          expect(posts.first().getText()).toContain('admin');
        });

        it('should delete the last post', function() {
          element.all(By.css('.delete')).last().click();

          var posts = element.all(By.repeater('post in listDir.posts'));

          expect(posts.count()).toBe(postsCountBefore - 1);
          expect(posts.first().getText()).toContain(editPost.text);
          expect(posts.first().getText()).toContain('admin');
        });
      });

      it('should logout', function() {
        helpers.logout();
      });
    });
  }
}
