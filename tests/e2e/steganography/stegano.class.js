'use strict';

let MainClass = require('../lib/main.class');
let PostClass = require('../posts/post.class');
let postHelper = new PostClass;
let ProfileClass = require('../user/profile.class');
let profileHelper = new ProfileClass;

class SteganoClass extends MainClass {
  constructor() {
    super();
    this.postText = 'Top secret';
  }

  goToTopic() {
    element(By.css('[ui-sref="section.list"]')).click();
    this.sections.first().click();
    this.topics.first().click();
  }

  firstStep() {
    this.goToTopic();
    postHelper.addPost(this.postText);
  }

  secondStep() {
    postHelper.editLastPostWithNothing();
  }

  thirdStep() {
    profileHelper.updateCatYears('2');
    browser.switchTo().alert().accept();
    this.goToTopic();
  }

  get switch() {
    return element(By.css('.onoffswitch-label'));
  }

  addPost(publicText, hiddenText) {
    let normalInput = element(By.css('[ng-model="new.post.text"]'));
    this.inputOn(normalInput, publicText);

    let steganoInput = element.all(By.css('form.new-post textarea')).last();
    this.inputOn(steganoInput, hiddenText);

    postHelper.addImage();

    element(By.css('[type="submit"]')).click();
  }
}

module.exports = SteganoClass;
