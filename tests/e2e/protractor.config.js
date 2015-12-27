'use strict';

var port =  4444;

exports.config = {
    jasmineNodeOpts: {
        showColors: true,
        defaultTimeoutInterval: 300000
    },

    specs: ['**/*.scenario.js'],

    seleniumArgs: ['-browserTimeout=60'],

    seleniumAddress: 'http://localhost:4444/wd/hub',

    multiCapabilities: [{
        'browserName': 'chrome'
    }]
};
