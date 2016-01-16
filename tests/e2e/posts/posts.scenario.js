'use strict';
let PostClass = require('./post.class')
let AuthHelpers = require('../user/auth.helpers')

class PostsScenario extends PostClass {
  constructor() {
    super();
  }

  begin() {
    AuthHelpers.loginAs('admin', 'admin');
    browser.get('/sections');
    browser.sleep(500);
    this.sections.first().click();
    this.topics.first().click();
  }

  run() {
    describe('Posts scenario', () => {
      let newPost = {
        text: 'somePostName'
      };
      let editPost = {
        text: 'updatedPostName'
      };

      it('begin', () => {
        this.begin();
      });

      describe('Posts page', () => {
        let postsCountBefore;

        beforeEach(() => {
          this.posts.count().then((count) => {
            postsCountBefore = count;
          });
        });

        it('should add a new post', () => {
          this.addPost(newPost.text);
          this.addPost(newPost.text);

          expect(this.posts.count()).toBe(postsCountBefore + 2);
          expect(this.posts.last().getText()).toContain(newPost.text);
          expect(this.posts.last().getText()).toContain('admin');
        });

        it('should edit the first post', () => {
          this.editPost(0, editPost.text);

          expect(this.posts.first().getText()).toContain(editPost.text);
          expect(this.posts.first().getText()).toContain('admin');
        });

        it('should delete the last post', () => {
          this.deleteLast();

          expect(this.posts.count()).toBe(postsCountBefore - 1);
          expect(this.posts.first().getText()).toContain(editPost.text);
          expect(this.posts.first().getText()).toContain('admin');
        });
      });

      it('should logout', () => {
        AuthHelpers.logout();
      });
    });
  }
}

module.exports = new PostsScenario;
