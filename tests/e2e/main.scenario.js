'use strict';
describe('Main scenario', function() {
  it('should load the main page', function() {
    browser.get('/');
    expect(browser.isElementPresent(By.css('body'))).toBe(true);
  });
});
