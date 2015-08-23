// 'use strict';
// require('coffee-script/register');

// exports.config = {
//   jasmineNodeOpts: {
//     showColors: true,
//     defaultTimeoutInterval: 30000
//   },

//   specs: ['test/e2e/**/*.scenario.coffee'],

//   sauceUser: process.env.SAUCE_USERNAME,
//   sauceKey: process.env.SAUCE_ACCESS_KEY,
//   capabilities: {
//     'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER,
//     'build': process.env.TRAVIS_BUILD_NUMBER,
//     'browserName': 'chrome'
//   },

//   mocks: {
//     dir: 'mocks',
//   },

//   onPrepare: function(){
//     require('protractor-http-mock').config = {
//       rootDirectory: __dirname,
//       protractorConfig: 'protractor.config'
//     };
//      var FactoryGirl = require('factory_girl');
//      FactoryGirl.definitionFilePaths = [__dirname + '/factories'];
//      FactoryGirl.findDefinitions();
//   }
// };
