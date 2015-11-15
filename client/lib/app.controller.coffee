AppCtrl = () ->
  vm = this

  jQuery.getJSON("build.json").then (data) =>
    this.buildInfo  = data;

  return vm

AppCtrl.$inject = []

angular.module('forumSteganum')
.controller 'AppCtrl', AppCtrl
