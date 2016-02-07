'use strict';
var sections = require('./sections/sections.scenario');
var topics = require('./topics/topics.scenario');
var posts = require('./posts/posts.scenario');
var stegano = require('./steganography/stegano.scenario');
var users = require('./user/users.scenario');
var adminPanel = require('./user/admin.scenario');

sections.run();
topics.run();
posts.run();
stegano.run();
users.run();
adminPanel.run();
