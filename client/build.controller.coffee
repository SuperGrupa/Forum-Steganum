BuildCtrl = () ->
  jQuery.getJSON("build.json").then (data) =>
    this.info  = data;

  return this

angular.module('forumSteganum')
.controller 'BuildCtrl', BuildCtrl
